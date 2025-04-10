# script that has 2 functions:
# 1.) Combine all csv files in a given directory into a single csv file.
# 2.) Load all the data in the given csv file into a database table
# uncomment the appropriate method call at the bottom to get the desired behavior
#
# May need to do the following before running the script
# pip3 install pandas
# pip3 install mysql.connector
# pip3 install sqlalchemy
# pip3 install pymysql
#
# To run:
# 1.) Copy the ../credentials_example.json file into this directory and rename it either credentials_local.json
# or credentials_remote.json, depending on what's appropriate for your environment.
# 2.) In the new credentials file, edit the values as appropriate.
# 3.) Comment/uncomment the "credentials_file_path" variable below to point to the correct credentials file.
# 4.) Set the "test_mode" variable below to True or False depending on what you want. If test_mode is on, 
# no files or tables will be generated or modified, also more debugging statements are printed out.
# 5.) comment or uncomment the 'combine_csv_files()' and/or 'convert_to_db()' lines at the bottom as appropriate.
# 6.) /usr/local/bin/python3 /Users/jgeis/Work/DOH/TEDS-Processing/TEDS-D/LoadData_TEDS_D.py
#
# Note that the final combined_data.csv file will be significantly smaller than the 
# input files because all states other than Hawaii are stripped out.
#
import os
import pandas as pd
import mysql.connector as msql
from mysql.connector import Error
import sqlalchemy as sa
from sqlalchemy import create_engine, inspect
import json
import shutil
from datetime import datetime

current_file_directory = os.path.dirname(os.path.abspath(__file__))

# note: when changing to reading values from credential file, may need to do something about the quotes.  Not sure yet.
credentials_file_path = current_file_directory + '/credentials_local.json'
#credentials_file_path = current_file_directory + '/credentials_remote.json'
print(f"credentials_file_path: {credentials_file_path}")

# if test_mode is true, it doesn't write out any files or make any database changes.
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

def backup_existing_combined_file():
    # Define the file path for the combined data file
    combined_file_path = os.path.join(dir, "combined_data.csv")

    # Check if the file exists
    if os.path.exists(combined_file_path):
        # Generate a timestamp for the backup file name
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        backup_file_path = os.path.join(dir, "storage/", f"combined_data_{timestamp}.csv")

        # Move the existing file to the backup file
        shutil.move(combined_file_path, backup_file_path)
        print(f"Existing combined_data.csv moved to {backup_file_path}")
    else:
        print("No existing combined_data.csv file found.")


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
        print(file_path)

        # TODO: need to normalize the columns as they differ across the years. For all the columns for each year, see:
        # https://docs.google.com/spreadsheets/d/1Jrto9Tl0w27WwdSPLtSFg6VpsZzC7BpWjwkNaKYtYcY/edit#gid=0

        col_types = {"YEAR":"int","DISYR":"int","CASEID":"int","STFIPS":"int","CBSA":"int","CBSA2010":"int","CBSA2020":"int","EDUC":"int","MARSTAT":"int","SERVSETD":"int","SERVICES":"int","DETCRIM":"int","LOS":"int","PSOURCE":"int","NOPRIOR":"int","ARRESTS":"int","EMPLOY":"int","METHUSE":"int","PSYPROB":"int","PREG":"int","GENDER":"int","VET":"int","LIVARAG":"int","DAYWAIT":"int","SERVICES_D":"int","REASON":"int","EMPLOY_D":"int","LIVARAG_D":"int","ARRESTS_D":"int","DSMCRIT":"int","AGE":"int","RACE":"int","ETHNIC":"int","DETNLF":"int","DETNLF_D":"int","PRIMINC":"int","SUB1":"int","SUB2":"int","SUB3":"int","SUB1_D":"int","SUB2_D":"int","SUB3_D":"int","ROUTE1":"int","ROUTE2":"int","ROUTE3":"int","FREQ1":"int","FREQ2":"int","FREQ3":"int","FREQ1_D":"int","FREQ2_D":"int","FREQ3_D":"int","FRSTUSE1":"int","FRSTUSE2":"int","FRSTUSE3":"int","HLTHINS":"int","PRIMPAY":"int","FREQ_ATND_SELF_HELP":"int","FREQ_ATND_SELF_HELP_D":"int","ALCFLG":"int","COKEFLG":"int","MARFLG":"int","HERFLG":"int","METHFLG":"int","OPSYNFLG":"int","PCPFLG":"int","HALLFLG":"int","MTHAMFLG":"int","AMPHFLG":"int","STIMFLG":"int","BENZFLG":"int","TRNQFLG":"int","BARBFLG":"int","SEDHPFLG":"int","INHFLG":"int","OTCFLG":"int","OTHERFLG":"int","DIVISION":"int","REGION":"int","IDU":"int","ALCDRUG":"int","PMSA":"int","NUMSUBS":"int"}
        # these columns are not found in certain years (looking at you, 2007).  So need to add them in, 
        # otherwise we get a weird artifact where it makes the existing values in those columns into floats instead of ints 
        required_columns = ['SERVICES', 'ARRESTS', 'SERVICES_D', 'EMPLOY_D', 'LIVARAG_D', 'ARRESTS_D', 'DETNLF_D', 'SUB1_D', 'SUB2_D', 'SUB3_D', 'FREQ1_D', 'FREQ2_D', 'FREQ3_D', 'FREQ_ATND_SELF_HELP', 'FREQ_ATND_SELF_HELP_D']

        data = pd.DataFrame()
        # the formats between years change, so some have text some are numeric, handle both.
        if ("2021" in file_path):
            print("2021")
            # reading tedsd_puf_2021.csv fails unless encoding='latin-1'
            # don't provide the coltypes since this stupidly inconsistent year is already decoded and it's all strings
            data = pd.read_csv(file_path, low_memory=False, encoding='latin-1')

            # strip out everything but Hawaii as the end result was just too big
            data_hawaii = data[data['STFIPS'] == 'Hawaii']

            # normalize column names
            data_hawaii = data_hawaii.rename(columns={"CBSA2020": "CBSA"})
            print("inserting rows: ", len(data_hawaii))    
            combined_data = pd.concat([combined_data, data_hawaii], axis="rows")
            #if 'ARRESTS' in combined_data.columns:
            #    print("2. Unique values in ARRESTS:", combined_data['ARRESTS'].unique())    

        elif ("2015" in file_path
              or "2016" in file_path):
            print("2015 or 2016")
            # this works for non-2021, but not 2021
            data = pd.read_csv(file_path, dtype=col_types, encoding='latin-1')

            # strip out everything but Hawaii as the end result was just too big
            data_hawaii = data[data['STFIPS'] == 15]
            # not needed as we use DISYR instead
            data_hawaii = data_hawaii.drop(columns=['YEAR'])
            #data_hawaii = data_hawaii.drop(columns=['NUMSUBS'])

            print("inserting rows: ", len(data_hawaii))
            #if ("2016" in file_path):
            #    print(data_hawaii)
            #print("combined_data: ", len(combined_data), "data_hawaii: ", len(data_hawaii))
            combined_data = pd.concat([combined_data, data_hawaii], axis="rows").fillna("")
            #print("combined_data: ", len(combined_data), "data_hawaii: ", len(data_hawaii))
        elif ("2017" in file_path
              or "2018" in file_path
              or "2019" in file_path
              or "2020" in file_path): 
            print("2017-2020: ", file_path)
            # this works for non-2021, but not 2021
            data = pd.read_csv(file_path, dtype=col_types, encoding='latin-1')
            # strip out everything but Hawaii as the end result was just too big
            data_hawaii = data[data['STFIPS'] == 15] 
            # normalize column names
            data_hawaii = data_hawaii.rename(columns={"CBSA2010": "CBSA"})
            print("inserting rows: ", len(data_hawaii))
            combined_data = pd.concat([combined_data, data_hawaii], axis="rows").fillna("")         
        elif ("2022" in file_path): 
            print("2022")
            data = pd.read_csv(file_path, dtype=col_types, encoding='latin-1')

            # strip out everything but Hawaii as the end result was just too big
            data_hawaii = data[data['STFIPS'] == 15] 
            # normalize column names
            data_hawaii = data_hawaii.rename(columns={"CBSA2020": "CBSA"})
            print("inserting rows: ", len(data_hawaii))
            combined_data = pd.concat([combined_data, data_hawaii], axis="rows").fillna("")         
        elif ("2006" in file_path
              or "2007" in file_path
              or "2008" in file_path
              or "2009" in file_path
              or "2010" in file_path
              or "2011" in file_path
              or "2012" in file_path
              or "2013" in file_path
              or "2014" in file_path): 
            print("2006-2014")
            # this works for non-2021, but not 2021
            data = pd.read_csv(file_path, dtype=col_types, encoding='latin-1')

            # strip out everything but Hawaii as the end result was just too big
            data_hawaii = data[data['STFIPS'] == 15]
            # normalize column names    
            data_hawaii = data_hawaii.rename(columns={"SERVSETD": "SERVICES"})

            # Ensure all required columns exist
            for col in required_columns:
                if col not in data_hawaii.columns:
                    data_hawaii[col] = -9  # Add the missing column with a default value

            #data_hawaii = data_hawaii.drop(columns=['NUMSUBS'])
            #data_hawaii = data_hawaii.drop(columns=['PMSA'])
            print("inserting rows: ", len(data_hawaii))
            combined_data = pd.concat([combined_data, data_hawaii], axis="rows").fillna("")

    # TODO: some of the data has a space before the value, need to strip off whitespace

    # Write the combined data to a new .csv file
    if not test_mode:
        # Call the function before creating a new combined_data.csv
        backup_existing_combined_file()
        print("inserting total rows: ", len(combined_data))
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

        # read the data from the csv file, yes, I could have just made a bunch
        # of dicts and used convertersdict, but the python stuff to myssql is flaky as it is
        df = pd.read_csv(full_file_path, low_memory=False, sep=',', quotechar='\"', encoding='utf8') 
        
        # add data to the table
        if not test_mode:
            df.to_sql(db_table, con=engine, index=False, if_exists='append')
        else:
            print("Test mode is on, combined data not saved.")

        # inserted 1,416,357 rows with 62 columns (TEDS_A).  Don't recall if this was just Hawaii or all states.
        # inserted 131,305 rows with 78 columns (TEDS_D).  Just Hawaii.
    except Error as e:
        print("Error while connecting", e)

# uncomment one or both of these to make something happen
combine_csv_files()
#convert_to_db()
# 136,287