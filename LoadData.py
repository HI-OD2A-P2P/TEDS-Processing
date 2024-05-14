# script that has 2 functions:
# 1.) Combine all csv files in a given directory into a single csv file.
# 2.) Load all the data in the given csv file into a database table
# uncomment the appropriate method call at the bottom to get the desired behavior
#
# May need to do the following before running the script
# pip3 install pandas
# pip3 install mysql.connector
# pip3 install sqlalchemy
#
# To run:
# 1.) Edit the 'dir', 'db_host', 'db_name', 'db_table', 'db_user', and 'db_pwd' variables as appropriate.
# 2.) comment or uncomment the 'combine_csv_files()' and/or 'convert_to_db()' lines at the bottom as appropriate.
# 3.) > /usr/local/bin/python3 /Users/jgeis/Work/DOH/TEDS-Processing/LoadData.py
#
import os
import pandas as pd
#import csv
import mysql.connector as msql
from mysql.connector import Error
import sqlalchemy as sa
from sqlalchemy import create_engine
#from sqlalchemy import text
#from sqlalchemy import create_engine, types

# fields you will need to edit before running this
dir = "<Your Directory Path Here>"
fileName = "combined_data.csv"
fullFilePath = dir + fileName
#db_driver = "mysql+pymysql"
db_driver = "mssql+pymssql"
db_host = '<Your database host here>'
db_name = '<Your database name here>'
db_table = '<Your table name here>'
db_user = "<Your Username Here>"
db_pwd = "<Your Password Here>"

# merges all .csv files found in the <dir> into one csv named <fileName>
# merges all .csv files found in the <dir> into one csv named <fileName>
def combine_csv_files():
    print("Running combine_csv_files")
    # Get a list of all files in the directory
    all_files = os.listdir(dir)
    #print(all_files)
    # Filter the list to only include .csv files
    csv_files = [file for file in all_files if file.endswith('.csv')]
    # Initialize an empty DataFrame to store the combined data
    combined_data = pd.DataFrame()
    # Loop through each .csv file and append its data to the combined data DataFrame
    for file in csv_files:
        file_path = os.path.join(dir, file)
        #print(file_path)
        # do NOT change file_path to fullFilePath here as they refer to different files
        data = pd.read_csv(file_path)
        
        # strip out Hawaii as the end result was just too big
        data_hawaii = data[data['STFIPS'] == 15]
        combined_data = pd.concat([combined_data, data_hawaii])

        #combined_data = pd.concat([combined_data, data])
        #combined_data = combined_data.append(data)

    # Write the combined data to a new .csv file
    combined_data.to_csv(fullFilePath, index=False)

# reads in <filename> and appends the data to <tableName>
def convert_to_db():
    print("Running convert_to_db")
    try:
        # create the db connection
        connection_url = sa.engine.URL.create(
            drivername=db_driver,
            username=db_user,
            password=db_pwd,
            host=db_host,
            database=db_name)

        print(connection_url)
        engine = create_engine(connection_url)

        # read the data from the csv file, yes, I could have just made a bunch
        # of dicts and used convertersdict, but the python stuff to myssql is flaky as it is
        df = pd.read_csv(fullFilePath, sep=',', quotechar='\'', encoding='utf8') 
        
        # add data to the table
        df.to_sql(db_table, con=engine, index=False, if_exists='append')

        # used this to make sure connection was good, uncomment import text to work
        #with engine.connect() as conn:
        #    query = "select count(*) from dbo.TEDS_XWALK_AGE"
        #    result = conn.execute(text(query))

        # inserted 1,416,357 rows with 62 columns
    except Error as e:
        print("Error while connecting", e)

# uncomment one or both of these to make something happen
#combine_csv_files()
#convert_to_db()