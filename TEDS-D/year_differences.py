# A script to double check the differences we found via parsing the PDF files match the differences we find in the data.
# Parsing PDF is not guaranteed to be accurate, so some manual corrections may be required, the problem is finding
# the errors to begin with as there is no way to manually comb the data.  To combat that, I wrote this to report 
#  all the differences between two years and we can compare that to the pdf parsed results.
# It works by:
#  going through the following years "2014, 2015, 2016, 2017, 2018, 2019, 2020, 2022" 
#  to compare the values between each two consecutive years in a mysql database.
#  It then prints out any differences to show the year, field_name, and the differing values.
# the query to run should be like the following:
# SELECT distinct A.<field_name> FROM TEDS_D as A where A.DISYR = <year> EXCEPT SELECT distinct B.<field_name> FROM TEDS_D as B where B.DISYR = <year + 1>
# UNION
# SELECT distinct B.<field_name> FROM TEDS_D as B where B.DISYR = <year + 1> EXCEPT SELECT distinct A.<field_name> FROM TEDS_D as A where A.DISYR = <year>;
#
# For example, for the field_names value of 'EDUC' and the year of 2014, the query will look like this:
# SELECT distinct A.EDUC FROM TEDS_D as A where A.DISYR = 2014 EXCEPT SELECT distinct B.EDUC FROM TEDS_D as B where B.DISYR = 2015
# UNION
# SELECT distinct B.EDUC FROM TEDS_D as B where B.DISYR = 2015 EXCEPT SELECT distinct A.EDUC FROM TEDS_D as A where A.DISYR = 2014;
#
# To run:
# /opt/anaconda3/bin/python3 /Users/jgeis/Work/DOH/TEDS-Processing/TEDS-D/year_differences.py > year_differences.txt

import mysql.connector
import os
import json

current_file_directory = os.path.dirname(os.path.abspath(__file__))

# note: when changing to reading values from credential file, may need to do something about the quotes.  Not sure yet.
credentials_file_path = current_file_directory + '/credentials_local.json'
#credentials_file_path = current_file_directory + '/credentials_remote.json'
print(f"credentials_file_path: {credentials_file_path}")

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
connection = '' 

test_mode = False
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

# Database connection configuration
config = {
    'host': db_host,
    'user': db_user,
    'password': db_pwd,
    'database': db_name
}

# Field names and years
field_names = [
    "EDUC", "MARSTAT", "SERVICES", "DETCRIM", "LOS", "PSOURCE", "NOPRIOR", "ARRESTS", "EMPLOY", "METHUSE",
    "PSYPROB", "PREG", "GENDER", "VET", "LIVARAG", "DAYWAIT", "SERVICES_D", "REASON", "EMPLOY_D", "LIVARAG_D",
    "ARRESTS_D", "DSMCRIT", "AGE", "RACE", "ETHNIC", "DETNLF", "DETNLF_D", "PRIMINC", "SUB1", "SUB2", "SUB3",
    "SUB1_D", "SUB2_D", "SUB3_D", "ROUTE1", "ROUTE2", "ROUTE3", "FREQ1", "FREQ2", "FREQ3", "FREQ1_D", "FREQ2_D",
    "FREQ3_D", "FRSTUSE1", "FRSTUSE2", "FRSTUSE3", "HLTHINS", "PRIMPAY", "FREQ_ATND_SELF_HELP", "FREQ_ATND_SELF_HELP_D",
    "ALCFLG", "COKEFLG", "MARFLG", "HERFLG", "METHFLG", "OPSYNFLG", "PCPFLG", "HALLFLG", "MTHAMFLG", "AMPHFLG",
    "STIMFLG", "BENZFLG", "TRNQFLG", "BARBFLG", "SEDHPFLG", "INHFLG", "OTCFLG", "OTHERFLG", "DIVISION", "REGION",
    "IDU", "ALCDRUG", "SERVSETD"
]
years = [2014, 2015, 2016, 2017, 2018, 2019, 2020, 2022]

# Function to execute the queries
def find_differences():
    try:
        # Connect to the database
        connection = mysql.connector.connect(**config)
        cursor = connection.cursor()

        # Iterate over fields and years
        for field_name in field_names:
            for i in range(len(years) - 1):
                year = years[i]
                next_year = years[i + 1]

                # Build the SQL query
                query = f"""
                SELECT DISTINCT A.{field_name} FROM TEDS_D AS A WHERE A.DISYR = {year} 
                EXCEPT 
                SELECT DISTINCT B.{field_name} FROM TEDS_D AS B WHERE B.DISYR = {next_year}
                UNION
                SELECT DISTINCT B.{field_name} FROM TEDS_D AS B WHERE B.DISYR = {next_year} 
                EXCEPT 
                SELECT DISTINCT A.{field_name} FROM TEDS_D AS A WHERE A.DISYR = {year};
                """

                # Execute the query
                cursor.execute(query)
                differences = cursor.fetchall()

                # Print differences
                if differences:
                    print(f"Differences for field '{field_name}' between {year} and {next_year}:")
                    for diff in differences:
                        print(f"  {diff[0]}")
                    print("-" * 40)

    except mysql.connector.Error as err:
        print(f"Error: {err}")
    finally:
        if connection.is_connected():
            cursor.close()
            connection.close()

# Run the function
find_differences()