# script that generates the sql update commands change the data from numbers to actual human 
# readable values via the teds_d_harmonization.csv file.
#
# does the following:
# -reads a csv file with the following format: id,2019,2018,2017,2016,2015,2006-2014,code,field
# -for each of the following year columns 2019,2018,2017,2016,2015 from the csv file
# -run a mysql update command: 
# update 
#     dbo.TEDS_D as T
# set 
#     T.<csv field column value> = <csv year column value>
# where 
#     T.<csv field column value> = <csv code column value>
#     and T.DISYR = <csv year column name>;
# 
# for example, if the year column being used is 2019 and the values of a row in the csv file are as follows:
# 1, A, B, C, D, E, F, 2, VET
# the resulting mysql update command would be:
# update 
#     dbo.TEDS_D as T
# set 
#     T.VET = 'A'
# where  
#     T.VET = 2
#     and T.DISYR = 2019;
#
# To run:
# /usr/local/bin/python3 /Users/jgeis/Work/DOH/TEDS-Processing/TEDS-D/TEDS_D_conversion.py > output.sql
#
# To execute the resulting sql on the database:
# mysql -u jgeis -p doh < output.sql

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
            field = row['field']
            
                        # Skip if the field starts with 'CBSA'
            if field.startswith('CBSA') or field == 'DISYR' or field == 'CASEID' or field == 'PMSA':
                continue

            # Process each year column
            for year in ['2022','2020','2019', '2018', '2017', '2016', '2015']:
                # Get the value for the current year
                year_value = row[year]
                
                # Generate the MySQL UPDATE command
                update_command = f"""
                    update 
                        TEDS_D as T
                    set 
                        T.{field} = '{year_value}'
                    where  
                        T.{field} = {code}
                        and T.DISYR = {year};
                    """
                # Print the generated command
                print(update_command)


            # Process the 2006-2014 column
            range_value = row['2006-2014']
            # Generate the MySQL UPDATE command for the range of years
            update_command_range = f"""
                update 
                    TEDS_D as T
                set 
                    T.{field} = '{range_value}'
                where  
                    T.{field} = {code}
                    and T.DISYR between 2006 and 2014;
                """
            # Print the generated command for the range
            print(update_command_range)


# Replace 'your_file.csv' with the path to your CSV file
csv_file = 'teds_d_harmonization.csv'
generate_mysql_updates(csv_file)
