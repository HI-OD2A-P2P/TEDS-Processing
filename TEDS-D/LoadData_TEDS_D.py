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
# 6.) > /usr/local/bin/python3 /Users/jgeis/Work/DOH/TEDS-Processing/TEDS-D/LoadData_TEDS_D.py
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

# merges all .csv files found in the <dir> into one csv named <fileName>
def combine_csv_files():
    print("Running combine_csv_files")

    # Check if the file exists
    if os.path.exists(full_file_path):
        print(f"The file {full_file_path} already exists. Skipping the combination process.")
        return
        # If the file exists, delete it
        #os.remove(full_file_path)
        #print("Pre-existing output file deleted")

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

        # from non-2021 file
        #col_types = {"DISYR":"string","CASEID":"string","STFIPS":"string","CBSA2010":"string","EDUC":"string","MARSTAT":"string","SERVICES":"string","DETCRIM":"string","LOS":"string","PSOURCE":"string","NOPRIOR":"string","ARRESTS":"string","EMPLOY":"string","METHUSE":"string","PSYPROB":"string","PREG":"string","GENDER":"string","VET":"string","LIVARAG":"string","DAYWAIT":"string","SERVICES_D":"string","REASON":"string","EMPLOY_D":"string","LIVARAG_D":"string","ARRESTS_D":"string","DSMCRIT":"string","AGE":"string","RACE":"string","ETHNIC":"string","DETNLF":"string","DETNLF_D":"string","PRIMINC":"string","SUB1":"string","SUB2":"string","SUB3":"string","SUB1_D":"string","SUB2_D":"string","SUB3_D":"string","ROUTE1":"string","ROUTE2":"string","ROUTE3":"string","FREQ1":"string","FREQ2":"string","FREQ3":"string","FREQ1_D":"string","FREQ2_D":"string","FREQ3_D":"string","FRSTUSE1":"string","FRSTUSE2":"string","FRSTUSE3":"string","HLTHINS":"string","PRIMPAY":"string","FREQ_ATND_SELF_HELP":"string","FREQ_ATND_SELF_HELP_D":"string","ALCFLG":"string","COKEFLG":"string","MARFLG":"string","HERFLG":"string","METHFLG":"string","OPSYNFLG":"string","PCPFLG":"string","HALLFLG":"string","MTHAMFLG":"string","AMPHFLG":"string","STIMFLG":"string","BENZFLG":"string","TRNQFLG":"string","BARBFLG":"string","SEDHPFLG":"string","INHFLG":"string","OTCFLG":"string","OTHERFLG":"string","DIVISION":"string","REGION":"string","IDU":"string","ALCDRUG":"string","CBSA":"string","PMSA":"string","SERVSETD":"string","NUMSUBS":"string","YEAR":"string"}
        # 2021 file  
        #col_types = {"YEAR":"double","NUMSUBS":"double","SERVSETD":"double","PMSA":"double","CBSA":"double","CBSA2010":"double","DISYR": "int","CASEID": "int","STFIPS": "string","EDUC": "string","MARSTAT": "string","SERVICES": "string","DETCRIM": "string","LOS": "string","PSOURCE": "string","NOPRIOR": "string","ARRESTS": "string","EMPLOY": "string","METHUSE": "string","PSYPROB": "string","PREG": "string","GENDER": "string","VET": "string","LIVARAG": "string","DAYWAIT": "string","SERVICES_D": "string","REASON": "string","EMPLOY_D": "string","LIVARAG_D": "string","ARRESTS_D": "string","DSMCRIT": "string","AGE": "string","RACE": "string","ETHNIC": "string","DETNLF": "string","DETNLF_D": "string","PRIMINC": "string","SUB1": "string","SUB2": "string","SUB3": "string","SUB1_D": "string","SUB2_D": "string","SUB3_D": "string","ROUTE1": "string","ROUTE2": "string","ROUTE3": "string","FREQ1": "string","FREQ2": "string","FREQ3": "string","FREQ1_D": "string","FREQ2_D": "string","FREQ3_D": "string","FRSTUSE1": "string","FRSTUSE2": "string","FRSTUSE3": "string","HLTHINS": "string","PRIMPAY": "string","FREQ_ATND_SELF_HELP": "string","FREQ_ATND_SELF_HELP_D": "string","ALCFLG": "string","COKEFLG": "string","MARFLG": "string","HERFLG": "string","METHFLG": "string","OPSYNFLG": "string","PCPFLG": "string","HALLFLG": "string","MTHAMFLG": "string","AMPHFLG": "string","STIMFLG": "string","BENZFLG": "string","TRNQFLG": "string","BARBFLG": "string","SEDHPFLG": "string","INHFLG": "string","OTCFLG": "string","OTHERFLG": "string","DIVISION": "string","REGION": "string","IDU": "string","ALCDRUG": "string","CBSA2020": "string"}

        data = pd.DataFrame()
        # the formats between years change, so some have text some are numeric, handle both.
        if ("2021" in file_path):
            print("2021")
            # reading tedsd_puf_2021.csv fails unless encoding='latin-1'
            data = pd.read_csv(file_path, low_memory=False, encoding='latin-1')

            # strip out everything but Hawaii as the end result was just too big
            data_hawaii = data[data['STFIPS'] == 'Hawaii']
            # normalize column names
            data_hawaii.rename(columns={"CBSA2020": "CBSA"})

            combined_data = pd.concat([combined_data, data_hawaii])
        elif ("2015" in file_path
              or "2016" in file_path):
            print("2015 or 2016")
            # this works for non-2021, but not 2021
            data = pd.read_csv(file_path, encoding='latin-1')

            # strip out everything but Hawaii as the end result was just too big
            data_hawaii = data[data['STFIPS'] == 15]
            # not needed as we use DISYR instead
            data_hawaii = data_hawaii.drop(columns=['YEAR'])        
            combined_data = pd.concat([combined_data, data_hawaii]).fillna("")
        elif ("2017" in file_path
              or "2018" in file_path
              or "2019" in file_path
              or "2020" in file_path): 
            print("2017, 2018, 2019, or 2020")
            # this works for non-2021, but not 2021
            data = pd.read_csv(file_path, encoding='latin-1')

            # strip out everything but Hawaii as the end result was just too big
            data_hawaii = data[data['STFIPS'] == 15] 
            # normalize column names
            data_hawaii.rename(columns={"CBSA2010": "CBSA"})
     
            combined_data = pd.concat([combined_data, data_hawaii]).fillna("")         
        
        elif ("2014" in file_path) :
            print("2006_2014")
            # this works for non-2021, but not 2021
            data = pd.read_csv(file_path, encoding='latin-1')

            # strip out everything but Hawaii as the end result was just too big
            data_hawaii = data[data['STFIPS'] == 15]
            # normalize column names    
            data_hawaii.rename(columns={"SERVSETD": "SERVICES"})
            combined_data = pd.concat([combined_data, data_hawaii]).fillna("")

    # TODO: some of the data has a space before the value, need to strip off whitespace

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
#combine_csv_files()
convert_to_db()