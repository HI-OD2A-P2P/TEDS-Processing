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
# 3.) > /usr/local/bin/python3 /Users/jgeis/Work/DOH/TEDS-Processing/TEDS-A/LoadData.py
#
# Note that the final combined_data.csv file will be significantly smaller than the 
# input files because all states other than Hawaii are stripped out.
#
import os
import pandas as pd
#import csv
import mysql.connector as msql
from mysql.connector import Error
import sqlalchemy as sa
from sqlalchemy import create_engine, inspect
import json

#from sqlalchemy import text
#from sqlalchemy import create_engine, types

current_file_directory = os.path.dirname(os.path.abspath(__file__))

# note: when changing to reading values from credential file, may need to do something about the quotes.  Not sure yet.
credentials_file_path = current_file_directory + '/credentials_local.json'
#credentials_file_path = 'credentials_remote.json'
print(f"credentials_file_path: {credentials_file_path}")

# if test_mode is true, don't actually write out any files or make and database changes
#test_mode = True
test_mode = False

# Read the JSON file
with open(credentials_file_path, 'r') as file:
    data = json.load(file)

# Extract values to variables
dir = data["dir"]
file_name = data["file_name"]
db_driver = data["db_driver"]
db_host = data["db_host"]
db_name = data["db_name"]
db_table = data["db_table"]
db_user = data["db_user"]
db_pwd = data["db_pwd"]
full_file_path = dir + file_name

# Print the variables to verify
if test_mode:
    print(f"dir: {dir}")
    print(f"file_name: {file_name}")
    print(f"db_driver: {db_driver}")
    print(f"db_host: {db_host}")
    print(f"db_name: {db_name}")
    print(f"db_table: {db_table}")
    print(f"db_user: {db_user}")
    print(f"db_pwd: {db_pwd}")

# merges all .csv files found in the <dir> into one csv named <file_name>
def combine_csv_files():
    print("Running combine_csv_files")

    # Check if the target file already exists
    if os.path.exists(full_file_path):
        print(f"The file {full_file_path} already exists. Skipping the combination process.")
        return
    
    # Get a list of all files in the directory
    all_files = os.listdir(dir)
    #print(all_files)
    # Filter the list to only include .csv files
    csv_files = [file for file in all_files if file.endswith('.csv')]
    # Initialize an empty DataFrame to store the combined data
    combined_data = pd.DataFrame()
    # Loop through each .csv file and append its data to the combined data DataFrame
    for file in csv_files:
        if file == file_name:
            print(f"file: {file_name} already exists")
        else:
            file_path = os.path.join(dir, file)
            #print(file_path)
            # do NOT change file_path to full_file_path here as they refer to different files
            data = pd.read_csv(file_path)
            
            # strip out Hawaii as the end result was just too big
            data_hawaii = data[data['STFIPS'] == 15]
            combined_data = pd.concat([combined_data, data_hawaii])

            #combined_data = pd.concat([combined_data, data])
            #combined_data = combined_data.append(data)

    # Write the combined data to a new .csv file
    if not test_mode:
        combined_data.to_csv(full_file_path, index=False)
    else:
        print("Test mode is on, combined data not saved.")

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

        # Check if the table already exists
        inspector = inspect(engine)
        if db_table in inspector.get_table_names():
            print(f"The table {db_table} already exists. Exiting the function.")
            return

        # read the data from the csv file, yes, I could have just made a bunch
        # of dicts and used convertersdict, but the python stuff to myssql is flaky as it is
        df = pd.read_csv(full_file_path, sep=',', quotechar='\'', encoding='utf8') 
        
        # add data to the table
        if not test_mode:
            df.to_sql(db_table, con=engine, index=False, if_exists='append')
        else:
            print("Test mode is on, combined data not saved.")

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