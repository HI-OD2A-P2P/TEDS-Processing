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
# 1.) Edit the 'dir', 'db_host', 'db_name', 'db_table', 'db_user', and 'db_pwd' variables as appropriate.
# 2.) comment or uncomment the 'combine_csv_files()' and/or 'convert_to_db()' lines at the bottom as appropriate.
# 3.) > /usr/local/bin/python3 /Users/jgeis/Work/DOH/TEDS-Processing/LoadData.py
#
import os
import pandas as pd
import mysql.connector as msql
from mysql.connector import Error
import sqlalchemy as sa
from sqlalchemy import create_engine

# fields you will need to edit before running this
#dir = "<Your Directory Path Here>"
dir = "/Users/jgeis/Work/DOH/TEDS-Processing/TEDS-D/csv_files/"
fileName = "combined_data.csv"
fullFilePath = dir + fileName
db_driver = "mysql+pymysql"
#db_driver = "mssql+pymssql"
#db_host = '<Your database host here>'
#db_host = "amhd-sql-data.database.usgovcloudapi.net"
db_host = "localhost"
#db_name = '<Your database name here>'
#db_name = "DOH_AMHD_NO_PII"
db_name = "doh"
#db_table = '<Your table name here>'
#db_table = 'dbo.TEDS_ALL_NUMERIC'
#db_table = 'TEDS_A_Numeric'
db_table = 'TEDS_D'
#db_user = "<Your Username Here>"
#db_user = "JenniferGeis"
db_user = "jgeis"
#db_pwd = "<Your Password Here>"
#db_pwd = "doh_AMHD@2022!"
db_pwd = "ehuKanoa"

# merges all .csv files found in the <dir> into one csv named <fileName>
# merges all .csv files found in the <dir> into one csv named <fileName>
def combine_csv_files():
    print("Running combine_csv_files")

    # Check if the file exists
    if os.path.exists(fullFilePath):
        # If the file exists, delete it
        os.remove(fullFilePath)
        print("Pre-existing output file deleted")

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
        if (file_path.endswith("2021.csv")):
            print("2021")
            # reading tedsd_puf_2021.csv fails unless encoding='latin-1'
            data = pd.read_csv(file_path, low_memory=False, encoding='latin-1')

            # strip out everything but Hawaii as the end result was just too big
            data_hawaii = data[data['STFIPS'] == 'Hawaii']
            # normalize column names
            data_hawaii.rename(columns={"CBSA2020": "CBSA"})

            combined_data = pd.concat([combined_data, data_hawaii])
        elif (file_path.endswith("2015.csv") 
              or file_path.endswith("2016.csv")):
            print("2015 or 2016")
            # this works for non-2021, but not 2021
            data = pd.read_csv(file_path, encoding='latin-1')

            # strip out everything but Hawaii as the end result was just too big
            data_hawaii = data[data['STFIPS'] == 15]
            # not needed as we use DISYR instead
            data_hawaii = data_hawaii.drop(columns=['YEAR'])        
            combined_data = pd.concat([combined_data, data_hawaii]).fillna("")
        elif (file_path.endswith("2017.csv") 
              or file_path.endswith("2018.csv") 
              or file_path.endswith("2019.csv") 
              or file_path.endswith("2020.csv")):
            print("2017, 2018, 2019, or 2020")
            # this works for non-2021, but not 2021
            data = pd.read_csv(file_path, encoding='latin-1')

            # strip out everything but Hawaii as the end result was just too big
            data_hawaii = data[data['STFIPS'] == 15] 
            # normalize column names
            data_hawaii.rename(columns={"CBSA2010": "CBSA"})
     
            combined_data = pd.concat([combined_data, data_hawaii]).fillna("")         
        
        elif (file_path.endswith("2014.csv")) :
            print("2006_2014")
            # this works for non-2021, but not 2021
            data = pd.read_csv(file_path, encoding='latin-1')

            # strip out everything but Hawaii as the end result was just too big
            data_hawaii = data[data['STFIPS'] == 15]
            # normalize column names
            data_hawaii.rename(columns={"SERVSETD": "SERVICES"})

            #data_hawaii["ARRESTS_D"] = ""
            #data_hawaii["DETNLF_D"] = ""  
            #data_hawaii["EMPLOY_D"] = ""  
            #data_hawaii["FREQ_ATND_SELF_HELP"] = ""  
            #data_hawaii["FREQ_ATND_SELF_HELP_D"] = ""  
            #data_hawaii["FREQ1_D"] = ""  
            #data_hawaii["FREQ2_D"] = ""  
            #data_hawaii["FREQ3_D"] = ""  
            #data_hawaii["LIVARAG_D"] = ""  
            #data_hawaii["SERVICES_D"] = ""  
            #data_hawaii["SUB1_D"] = ""  
            #data_hawaii["SUB2_D"] = ""  
            #data_hawaii["SUB3_D"] = ""  
            #data_hawaii["YEAR"] = ""  
            combined_data = pd.concat([combined_data, data_hawaii]).fillna("")

    # TODO: some of the data has a space before the value, need to strip off whitespace

    # getting pandas.errors.ParserError: Error tokenizing data. C error: Expected 82 fields in line 16532, saw 90
    # get first line of each year, put in ../temp.csv and see differences.

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
        df = pd.read_csv(fullFilePath, sep=',', quotechar='\"', encoding='utf8') 
        
        # add data to the table
        df.to_sql(db_table, con=engine, index=False, if_exists='append',low_memory=False)

        # used this to make sure connection was good, uncomment import text to work
        #with engine.connect() as conn:
        #    query = "select count(*) from dbo.TEDS_XWALK_AGE"
        #    result = conn.execute(text(query))

        # inserted 1,416,357 rows with 62 columns (TEDS_A).  Don't recall if this was just Hawaii or all states.
        # inserted 126,129 rows with 81 columns (TEDS_D).  Just Hawaii.
    except Error as e:
        print("Error while connecting", e)

# uncomment one or both of these to make something happen
#combine_csv_files()
convert_to_db()