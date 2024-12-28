# Generates the sql update commands to change the data from human 
# readable values to numbers via the merged_codes_result.csv file.
# 
# this is only needed for 2021 because for some reason, that one comes already encoded.
# Some may be lucky enough not to need this, but since I need to move the data over to a
# mssql server with limited space, I need everything to be in its encoded format before 
# I move it over, then I can load it into the db and run the update commands there.
#
# Does the following:
# -reads a csv file with the following format: code,value,2006-2014,2015,2016,2017,2018,2019,2020,2021,2022
# -for the year of 2021 from the csv file
# -run a mysql update command: 
# update 
#     dbo.TEDS_D as T
# set 
#     T.<csv value column value> = <csv code column value>
# where 
#    T.<csv value column value> = <csv year column value>
#     and T.DISYR = <csv year column name>;
# 
# for example, if the year column being used is 2019 and the values of a row in the csv file are as follows:
# VET, 2, A, B, C, D, E, F, G, H, I
# the resulting mysql update command would be:
# update 
#     dbo.TEDS_D as T
# set 
#     T.VET = 2
# where  
#     T.VET = 'A'
#     and T.DISYR = 2021;
###########################

# To run:
# /usr/local/bin/python3 /Users/jgeis/Work/DOH/TEDS-Processing/TEDS-D/TEDS_D_reverse_conversion.py > reverse_output.sql

# To execute the resulting sql on the database:
# mysql -u jgeis -p doh < reverse_output.sql

import csv

# Define the function to process the CSV and generate MySQL commands
def generate_mysql_updates(csv_file):
    # Open the CSV file for reading
    with open(csv_file, mode='r') as file:
        # Read the file as a dictionary
        reader = csv.DictReader(file)
        # Iterate over each row in the CSV
        for row in reader:
            # Extract the `code` and `field` columns
            code = row['code']
            field = row['Value']
            
            
            # Skip if the field starts with 'CBSA'
            if code.startswith('CBSA') or code == 'DISYR' or code == 'CASEID' or code == 'PMSA' or code == 'NUMSUBS':
                continue
            
            # Update for CBSA, just get rid of them
            update_command = f"""
                update 
                    TEDS_D as T
                set 
                    T.CBSA = ''
                where  
                    T.DISYR = 2021;
                """
            # Print the generated command
            print(update_command) 

            update_command = f"""
                update 
                    TEDS_D as T
                set 
                    T.PRIMPAY = '2'
                where  
                    T.PRIMPAY = 'Private insurance (Blue Cross/Blue Shield, other health insurance, workers compensation)'
                    and T.DISYR = 2021;
                """
            # Print the generated command
            print(update_command) 

            # Get the value for the current year
            year = '2021'
            year_value = row[year]
            
            # Generate the MySQL UPDATE command
            update_command = f"""
                update 
                    TEDS_D as T
                set 
                    T.{code} = '{field}'
                where  
                    T.{code} = '{year_value}'
                    and T.DISYR = {year};
                """
            # Print the generated command
            print(update_command)


# Replace 'your_file.csv' with the path to your CSV file
folder_path = "/Users/jgeis/Work/DOH/TEDS-Processing/TEDS-D/codebooks/"
csv_file = f"{folder_path}merged_codes_result_2021.csv"
generate_mysql_updates(csv_file)
