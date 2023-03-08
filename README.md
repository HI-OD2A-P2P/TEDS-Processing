# TEDS-Processing
TEDS dataset processing scripts for example or adoption.

Process by which you get the TEDS data from SAMHSA and load it into an SQL database 
with the numeric codes converted to human readable format:

1.) Download and unzip (the following download links are found at [SAMHSA TEDS](https://www.datafiles.samhsa.gov/dataset/treatment-episode-data-set-admissions-2020-teds-2020-ds0001)):
- [SAMHSA TEDS 2015-2019 data](https://www.datafiles.samhsa.gov/sites/default/files/field-uploads-protected/studies/TEDS-A-2015-2019/TEDS-A-2015-2019-datasets/TEDS-A-2015-2019-DS0001/TEDS-A-2015-2019-DS0001-bundles-with-study-info/TEDS-A-2015-2019-DS0001-bndl-data-csv.zip)
- [SAMHSA TEDS 2020 data](https://www.datafiles.samhsa.gov/sites/default/files/field-uploads-protected/studies/TEDS-A-2020/TEDS-A-2020-datasets/TEDS-A-2020-DS0001/TEDS-A-2020-DS0001-bundles-with-study-info/TEDS-A-2020-DS0001-bndl-data-csv_v1.zip)
- Also, if there are any subsequent years added, get those and then add their links here.

2.) Merge the above csv files into one file:
 - Open the LoadData.py file
 - Edit the engineType, dbName, tableName, username, password, dir, and fileName fields as appropriate.
 - Uncomment the "“combine_csv_files”" method call line at the bottom of the file and comment out the "convert_to_db" method call.
 - Run the “combine_csv_files” method to put the above csv files into one file.

3.) Load the data from the newly created csv file into a database table (will still be numeric, you can delete this one after):
 - Open the LoadData.py file
 - Edit the dbName, tableName, username, password, dir, and fileName fields as appropriate.
 - Uncomment the "convert_to_db" method call line at the bottom of the file and comment out the "combine_csv_files" method call.
 - Run the "convert_to_db" method to read the csv and put it all into a mysql table.

4.) Create the crosswalk tables if they don't already exist:
 - Open the codebook_tables.sql file (these values were derived from the values listed in the [Codebook.pdf](https://www.datafiles.samhsa.gov/sites/default/files/field-uploads-protected/studies/TEDS-A-2020/TEDS-A-2020-datasets/TEDS-A-2020-DS0001/TEDS-A-2020-DS0001-info/TEDS-A-2020-DS0001-info-codebook.pdf) file found on the [SAMHSA TEDS](https://www.datafiles.samhsa.gov/dataset/treatment-episode-data-set-admissions-2020-teds-2020-ds0001) site)
 - Run the create/insert statements

5.) Create a new table that has all the codes converted to human readable format:
 - Open the TEDS_conversion.sql or TEDS_DOH_conversion.sql file as appropriate.  (The DOH version eliminates all states except Hawaii and changes the column names to DOH's format)
 - Run the query
