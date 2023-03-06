# script that has 2 functions:
# 1.) Combine all csv files in a given directory into a single csv file.
# 2.) Load all the data in the given csv file into a database table
# uncomment the appropriate method call at the bottom to get the desired behavior
import os
import pandas as pd
#import csv
import mysql.connector as msql
from mysql.connector import Error
from sqlalchemy import create_engine
#from sqlalchemy import create_engine, types

# fields you will need to edit before running this
dir = "<Your Directory Path Here>"
fileName = "combined_data.csv"
fullFilePath = dir + fileName
dbName = 'doh'
tableName = 'TEDS_A_Numeric'
userName = "<Your Username Here>"
password = "<Your Password Here>"
engineType = "mssql+pymssql"
#engineType = "mysql+pymysql"


# merges all .csv files found in the <dir> into one csv named <fileName>
def combine_csv_files():
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
        combined_data = combined_data.append(data)
    # Write the combined data to a new .csv file
    #output_file_path = os.path.join(dir, 'combined_data.csv')
    combined_data.to_csv(fullFilePath, index=False)

# reads in <filename> and appends the data to <tableName>
def convert_to_db():
    try:
        # create the db connection
        conn = create_engine(f'{engineType}://{userName}:{password}@localhost/{dbName}')

        # read the data from the csv file
        df = pd.read_csv(fullFilePath, sep=',', quotechar='\'', encoding='utf8') 
        
        # add data to the table
        df.to_sql(tableName, con=conn, index=False, if_exists='append')
        # inserted 1,416,357 rows with 62 columns
    except Error as e:
        print("Error while connecting to MySQL", e)

# uncomment one or both of these to make something happen
#combine_csv_files()
#convert_to_db()

