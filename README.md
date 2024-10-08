# TEDS-Processing
- [Slideshow](https://docs.google.com/presentation/d/1IWLX31O8CVbDrOrpdBuJ3rtF05hRG0UdjMG_t6q7R-E/edit#slide=id.g1f99270e555_0_0)

## TEDS-A
TEDS A dataset processing scripts for example or adoption.

Process by which you get the TEDS data from SAMHSA and load it into an SQL database 
with the numeric codes converted to human readable format:

1.) Download and unzip the following into TEDS-A/csv_files: (links are found at [SAMHSA TEDS](https://www.datafiles.samhsa.gov/dataset/treatment-episode-data-set-admissions-2020-teds-2020-ds0001)):
- [SAMHSA TEDS A 2015-2019 data](https://www.datafiles.samhsa.gov/sites/default/files/field-uploads-protected/studies/TEDS-A-2015-2019/TEDS-A-2015-2019-datasets/TEDS-A-2015-2019-DS0001/TEDS-A-2015-2019-DS0001-bundles-with-study-info/TEDS-A-2015-2019-DS0001-bndl-data-csv.zip)
- [SAMHSA TEDS A 2020 data](https://www.datafiles.samhsa.gov/sites/default/files/field-uploads-protected/studies/TEDS-A-2020/TEDS-A-2020-datasets/TEDS-A-2020-DS0001/TEDS-A-2020-DS0001-bundles-with-study-info/TEDS-A-2020-DS0001-bndl-data-csv_v1.zip)
- [SAMHSA TEDS A 2021 data](https://www.datafiles.samhsa.gov/sites/default/files/field-uploads-protected/studies/TEDS-A-2021/TEDS-A-2021-datasets/TEDS-A-2021-DS0001/TEDS-A-2021-DS0001-bundles-with-study-info/TEDS-A-2021-DS0001-bndl-data-csv_v1.zip)
- 2021 was the last year available as of Aug 20, 2024, if there are any subsequent years added, get those and then add their links here.

2.) Merge the above csv files into one file:
 - Open the LoadData_TEDS_A.py file
 - Edit the credentials_local.json and/or credentials_remote.json files as appropriate.
 - Edit the LoadData_TEDS_A.py to point at the desired credential file and make sure test_mode variable is set to "False"
 - Uncomment the "“combine_csv_files”" method call line at the bottom of the file and comment out the "convert_to_db" method call.
 - The code is currently stripping out all states that are not Hawaii, so the resulting csv file will be significantly smaller than the input files.
 - Run the “combine_csv_files” method to put the above csv files into one file.  

3.) Load the data from the newly created csv file into a database table (will still be numeric, you can delete this later if you want):
 - Mysql Version
     * Open the LoadData_TEDS_A.py file
      * Edit the credentials_local.json and/or credentials_remote.json files as appropriate.
      * Edit the LoadData_TEDS_A.py to point at the desired credential file and make sure test_mode variable is set to "False"
      * Uncomment the "convert_to_db" method call line at the bottom of the file and comment out the "combine_csv_files" method call.
      * Run the "convert_to_db" method to read the csv and put it all into a mysql table.
 - MSSQL Version:
      * Unfortunately, I never got the code to run, the driver that writes out to the database was giving an error that basically said "hey, the issue isn't me" and I was unable to find a solution in the time given.  Instead, we just did a direct import of the csv file from step 2 into the database.  The process for that is as follows:
 --- ?????

4.) Create the crosswalk tables if they don't already exist:
 - Open the codebook_tables.sql file (these values were derived from the values listed in the [Codebook.pdf](https://www.datafiles.samhsa.gov/sites/default/files/field-uploads-protected/studies/TEDS-A-2020/TEDS-A-2020-datasets/TEDS-A-2020-DS0001/TEDS-A-2020-DS0001-info/TEDS-A-2020-DS0001-info-codebook.pdf) file found on the [SAMHSA TEDS A](https://www.datafiles.samhsa.gov/dataset/treatment-episode-data-set-admissions-2021-teds-2021-ds0001) site for TEDS-A and [Codebook.pdf](https://www.datafiles.samhsa.gov/sites/default/files/field-uploads-protected/studies/TEDS-D-2021/TEDS-D-2021-datasets/TEDS-D-2021-DS0001/TEDS-D-2021-DS0001-info/TEDS-D-2021-DS0001-info-codebook.pdf) file found on the [SAMHSA TEDS D](https://www.datafiles.samhsa.gov/dataset/teds-d-2021-ds0001-teds-d-2021-ds0001) site for TEDS-D )
 - Run the create/insert statements:  
 'mysql -u jgeis -p doh < codebook_tables_mysql.sql'

5.) Create a new table that has all the codes converted to human readable format:
 - Open the TEDS_conversion.sql (currently for mysql) or TEDS_DOH_conversion.sql file as appropriate.  (The DOH version is for mssql, eliminates all states except Hawaii if you left that stuff in during step 2, and changes the column names to DOH's more human-readable format)
 - Run one of the following queries:  
      * mysql -u jgeis -p doh < TEDS_conversion.sql
      * mysql -u jgeis -p doh < TEDS_DOH_conversion.sql 
 
## TEDS-D
1.) Download and unzip (the following download links are found at [SAMHSA TEDS](https://www.datafiles.samhsa.gov/dataset/teds-d-2021-ds0001-teds-d-2021-ds0001))
- [SAMHSA TEDS D 2006-2014 data](https://www.datafiles.samhsa.gov/sites/default/files/field-uploads-protected/studies/TEDS-D-2006-2014/TEDS-D-2006-2014-datasets/TEDS-D-2006-2014-DS0001/TEDS-D-2006-2014-DS0001-bundles-with-study-info/TEDS-D-2006-2014-DS0001-bndl-data-tsv.zip))
- [SAMHSA TEDS D 2015 data](https://www.datafiles.samhsa.gov/sites/default/files/field-uploads-protected/studies/TEDS-D-2015/TEDS-D-2015-datasets/TEDS-D-2015-DS0001/TEDS-D-2015-DS0001-bundles-with-study-info/TEDS-D-2015-DS0001-bndl-data-tsv.zip))
- [SAMHSA TEDS D 2016 data](https://www.datafiles.samhsa.gov/sites/default/files/field-uploads-protected/studies/TEDS-D-2016/TEDS-D-2016-datasets/TEDS-D-2016-DS0001/TEDS-D-2016-DS0001-bundles-with-study-info/TEDS-D-2016-DS0001-bndl-data-tsv.zip))
- [SAMHSA TEDS D 2017 data](https://www.datafiles.samhsa.gov/sites/default/files/field-uploads-protected/studies/TEDS-D-2017/TEDS-D-2017-datasets/TEDS-D-2017-DS0001/TEDS-D-2017-DS0001-bundles-with-study-info/TEDS-D-2017-DS0001-bndl-data-tsv.zip))
- [SAMHSA TEDS D 2018 data](https://www.datafiles.samhsa.gov/sites/default/files/field-uploads-protected/studies/TEDS-D-2018/TEDS-D-2018-datasets/TEDS-D-2018-DS0001/TEDS-D-2018-DS0001-bundles-with-study-info/TEDS-D-2018-DS0001-bndl-data-tsv.zip))
- [SAMHSA TEDS D 2019 data](https://www.datafiles.samhsa.gov/sites/default/files/field-uploads-protected/studies/TEDS-D-2019/TEDS-D-2019-datasets/TEDS-D-2019-DS0001/TEDS-D-2019-DS0001-bundles-with-study-info/TEDS-D-2019-DS0001-bndl-data-tsv_V1.zip))
- [SAMHSA TEDS D 2020 data](https://www.datafiles.samhsa.gov/sites/default/files/field-uploads-protected/studies/TEDS-D-2020/TEDS-D-2020-datasets/TEDS-D-2020-DS0001/TEDS-D-2020-DS0001-bundles-with-study-info/TEDS-D-2020-DS0001-bndl-data-csv_v1.zip))
- [SAMHSA TEDS D 2021 data](https://www.datafiles.samhsa.gov/sites/default/files/field-uploads-protected/studies/TEDS-D-2021/TEDS-D-2021-datasets/TEDS-D-2021-DS0001/TEDS-D-2021-DS0001-bundles-with-study-info/TEDS-D-2021-DS0001-bndl-data-csv_v1.zip))
- 2021 was the last year available as of Aug 20, 2024, if there are any subsequent years added, get those and then add their links here.
- The site says TEDS-D data collection began in 2000, but I only found downloads starting from 2006.
- Formats of the downloaded files change between the following years
     * 2014 & 2015
     * 2016 & 2017
     * 2020 & 2021

2.) Merge the above csv files into one file:
 - Open the LoadData_TEDS_D.py file
 - Edit the credentials_local.json and/or credentials_remote.json files as appropriate.
 - Edit the LoadData_TEDS_A.py to point at the desired credential file and make sure test_mode variable is set to "False" 
 - Uncomment the "“combine_csv_files”" method call line at the bottom of the file and comment out the "convert_to_db" method call.
 - Run the “combine_csv_files” method to put the above csv files into one file.

3.) Load the data from the newly created csv file into a database table (will still be numeric, you can delete this one after):
 - Open the LoadData_TEDS_D.py file
 - Edit the credentials_local.json and/or credentials_remote.json files as appropriate.
 - Edit the LoadData_TEDS_A.py to point at the desired credential file and make sure test_mode variable is set to "False"
 - Uncomment the "convert_to_db" method call line at the bottom of the file and comment out the "combine_csv_files" method call.
 - Run the "convert_to_db" method to read the csv and put it all into a mysql table.

4.) Create the crosswalk tables if they don't already exist:
 - Open the codebook_tables.sql file (these values were derived from the values listed in the [Codebook.pdf](https://www.datafiles.samhsa.gov/sites/default/files/field-uploads-protected/studies/TEDS-D-2006-2014/TEDS-D-2006-2014-datasets/TEDS-D-2006-2014-DS0001/TEDS-D-2006-2014-DS0001-info/TEDS-D-2006-2014-DS0001-info-codebook.pdf) file found on the [SAMHSA TEDS D](https://www.datafiles.samhsa.gov/dataset/teds-d-2021-ds0001-teds-d-2021-ds0001) site)
 - Run the create/insert statements:  
 'mysql -u jgeis -p doh < codebook_tables_mysql.sql'

5.) Create a new table that has all the codes converted to human readable format:
 - Open the TEDS_conversion.sql or TEDS_DOH_conversion.sql file as appropriate.  (The DOH version eliminates all states except Hawaii and changes the column names to DOH's format)
 - Run one of the following queries:  
      * mysql -u jgeis -p doh < TEDS_conversion.sql 
      * mysql -u jgeis -p doh < TEDS_DOH_conversion.sql 