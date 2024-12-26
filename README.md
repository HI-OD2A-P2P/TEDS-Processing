# Contact info:
Jennifer Geis
University of Hawaii at Manoa
ITS/Cyberinfrastructure
jgeis@hawaii.edu

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
 - MSSQL Version: Unfortunately, I never got the code to run, the driver that writes out to the database was giving an error that basically said "hey, the issue isn't me" and I was unable to find a solution in the time given.  Instead, we just did a direct import of the csv file from step 2 into the database.  The process for that is as follows:
      * If using a local machine to a VM, to copy the csv file over: go into finder, and do a copy on the csv file, then go to finder in the VM and do a paste.
      * Open MySQLWorkbench      
      * double click on the database to show popup menu
      * select 'Tasks'
      * select 'Import Data'
      * click the 'Next' button
      * for data source, select 'flat file source'
      * click the 'Browse' button
      * at the bottom, change from .txt to .csv
      * select the csv file
      * click the 'Open' button
      * click the 'Next' button
      * for destination, select 'Microsoft OLE DB Provider for SQL Server' (make sure you don't select 'Microsoft OLE DB Driver for SQL Server')
      * enter the server name
      * select 'Use SQL Server Authentication' and provide the username and password
      
      <!--
      [comment]: # (
      * Open MySQLWorkbench  (see https://stackoverflow.com/questions/17113812/how-to-export-table-data-in-mysql-workbench-to-csv for details)
      * Make sure settings allow all results instead of limiting to 1000.
      * select * from doh.TEDS_D2;
      * In the results area, click export and set output file type to csv.  Name the file TEDS_A.csv (or TEDS_D as appropriate).
      * In finder, copy the file, go to the vm, open finder there, paste.
      * Follow the instructions here: https://blog.skyvia.com/3-easy-ways-to-import-csv-file-to-sql-server/
      * Right click on the database
      * Select Tasks->Import Data
      * Click "Next" button
      * Select "flat file source" for the data source
      * Select the file your data is in.  Note, you'll have to switch the filetype from txt to csv or your file won't show up.
      * Click "Next" button
      * Click "Advanced"
      * Set the sizes for the columns: education: 100, DsmDiagnosisSuds4OrSuds19: 75, RouteOfAdministrationPrimary/Secondary/Tertiary: 75, PaymentSourcePrimaryExpectedOrActual: 100, DischargeReason: 55
      * Set DataType for AttendanceAtSubstanceUseSelfHelpGroupsInPast30B4Discharge, AgeAtAdmission, and SubstanceUseAtDischargePrimary to "text stream"
      * Finally just made all fields "text stream" and it seems to be working.  Will change formatting later once imported.
      * Click "Next" button
      * Select "Microsoft OLE DB Provider for SQL Server" 
      * Select "User SQL Server Authentication" and fill in the username and password
      * Click "Next" 3 times, then click "Finish" twice.)-->


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
- [SAMHSA TEDS D 2006-2014 data](https://www.datafiles.samhsa.gov/sites/default/files/field-uploads-protected/studies/TEDS-D-2006-2014/TEDS-D-2006-2014-datasets/TEDS-D-2006-2014-DS0001/TEDS-D-2006-2014-DS0001-bundles-with-study-info/TEDS-D-2006-2014-DS0001-bndl-data-tsv.zip)
- [SAMHSA TEDS D 2015 data](https://www.datafiles.samhsa.gov/sites/default/files/field-uploads-protected/studies/TEDS-D-2015/TEDS-D-2015-datasets/TEDS-D-2015-DS0001/TEDS-D-2015-DS0001-bundles-with-study-info/TEDS-D-2015-DS0001-bndl-data-tsv.zip)
- [SAMHSA TEDS D 2016 data](https://www.datafiles.samhsa.gov/sites/default/files/field-uploads-protected/studies/TEDS-D-2016/TEDS-D-2016-datasets/TEDS-D-2016-DS0001/TEDS-D-2016-DS0001-bundles-with-study-info/TEDS-D-2016-DS0001-bndl-data-tsv.zip)
- [SAMHSA TEDS D 2017 data](https://www.datafiles.samhsa.gov/sites/default/files/field-uploads-protected/studies/TEDS-D-2017/TEDS-D-2017-datasets/TEDS-D-2017-DS0001/TEDS-D-2017-DS0001-bundles-with-study-info/TEDS-D-2017-DS0001-bndl-data-tsv.zip)
- [SAMHSA TEDS D 2018 data](https://www.datafiles.samhsa.gov/sites/default/files/field-uploads-protected/studies/TEDS-D-2018/TEDS-D-2018-datasets/TEDS-D-2018-DS0001/TEDS-D-2018-DS0001-bundles-with-study-info/TEDS-D-2018-DS0001-bndl-data-tsv.zip)
- [SAMHSA TEDS D 2019 data](https://www.datafiles.samhsa.gov/sites/default/files/field-uploads-protected/studies/TEDS-D-2019/TEDS-D-2019-datasets/TEDS-D-2019-DS0001/TEDS-D-2019-DS0001-bundles-with-study-info/TEDS-D-2019-DS0001-bndl-data-tsv_V1.zip)
- [SAMHSA TEDS D 2020 data](https://www.datafiles.samhsa.gov/sites/default/files/field-uploads-protected/studies/TEDS-D-2020/TEDS-D-2020-datasets/TEDS-D-2020-DS0001/TEDS-D-2020-DS0001-bundles-with-study-info/TEDS-D-2020-DS0001-bndl-data-csv_v1.zip)
- [SAMHSA TEDS D 2021 data](https://www.datafiles.samhsa.gov/sites/default/files/field-uploads-protected/studies/TEDS-D-2021/TEDS-D-2021-datasets/TEDS-D-2021-DS0001/TEDS-D-2021-DS0001-bundles-with-study-info/TEDS-D-2021-DS0001-bndl-data-csv_v1.zip)
- [SAMHSA TEDS D 2022 data](https://www.samhsa.gov/data/system/files/media-puf-file/TEDS-D-2022-DS0001-bndl-data-csv_v1.zip) 
- 2022 was the last year available as of Dec 20, 2024, if there are any subsequent years added, get those and then add their links here.
- The site says TEDS-D data collection began in 2000, but I only found downloads starting from 2006.
- Formats of the downloaded files change between the following years
     * 2014 & 2015
     * 2016 & 2017
     * 2020 & 2021

TODO: do a reverse conversion on teds 2021.  It's the only one with text.  It's the import into mssql with the
values being text that's messing things up.  Particularly that the values have commas in them, even though they
are surrounded by quotes.  This would likely have been handled nicely if I could import an excel file, but the
system doesn't have the driver for it and as the files aren't small, I'm concerned about overwhelming the already
scarce disk space.


2.) Merge the above csv files into one file:
 - Open the LoadData_TEDS_D.py file
 - Edit the credentials_local.json and/or credentials_remote.json files as appropriate.
 - Edit the LoadData_TEDS_A.py to point at the desired credential file and make sure test_mode variable is set to "False" 
 - Uncomment the "“combine_csv_files”" method call line at the bottom of the file and comment out the "convert_to_db" method call.
 - Run the “combine_csv_files” method to put the above csv files into one file.

3.) Load the data from the newly created csv file into a database table (will still be numeric, you can delete this one after):
 - MySQL version:
    * Use MySQLWorkbench to do the import, or, do the following:
    * Open the LoadData_TEDS_D.py file
    * Edit the credentials_local.json and/or credentials_remote.json files as appropriate.
    * Edit the LoadData_TEDS_A.py to point at the desired credential file and make sure test_mode variable is set to "False"
    * Uncomment the "convert_to_db" method call line at the bottom of the file and comment out the "combine_csv_files" method call.
    * Run the "convert_to_db" method to read the csv and put it all into a mysql table.
 - MSSQL Version: Unfortunately, I never got the code to run, the driver that writes out to the database was giving an error that basically said "hey, the issue isn't me" and I was unable to find a solution in the time given.  Instead, we just did a direct import of the csv file from step 2 into the database.  The process for that is as follows:
      * If using a local machine to a VM, to copy the csv file over: go into finder, and do a copy on the csv file, then go to finder in the VM and do a paste.
      * Open MySQLWorkbench      
      * double click on the database to show the popup menu
      * select 'Tasks'
      * select 'Import Data'
      * click the 'Next' button
      * for data source, select 'flat file source'
      * click the 'Browse' button
      * at the bottom, change from .txt to .csv
      * select the csv file
      * click the 'Open' button
      * click the 'Next' button
      * for destination, select 'Microsoft OLE DB Provider for SQL Server' (make sure you don't select 'Microsoft OLE DB Driver for SQL Server')
      * enter the server name
      * select 'Use SQL Server Authentication' and provide the username and password

~~4.) Create the crosswalk tables if they don't already exist (note, this may not be necessary anymore, use the TEDS_D_conversion.py instead):
 - Open the codebook_tables.sql file (these values were derived from the values listed in the [Codebook.pdf](https://www.datafiles.samhsa.gov/sites/default/files/field-uploads-protected/studies/TEDS-D-2006-2014/TEDS-D-2006-2014-datasets/TEDS-D-2006-2014-DS0001/TEDS-D-2006-2014-DS0001-info/TEDS-D-2006-2014-DS0001-info-codebook.pdf) file found on the [SAMHSA TEDS D](https://www.datafiles.samhsa.gov/dataset/teds-d-2021-ds0001-teds-d-2021-ds0001) site)
 - Run the create/insert statements:  
 'mysql -u jgeis -p doh < codebook_tables_mysql.sql'
 
 5.) Create a new table that has all the codes converted to human readable format:
 - Open the TEDS_conversion.sql or TEDS_DOH_conversion.sql file as appropriate.  (The DOH version eliminates all states except Hawaii and changes the column names to DOH's format)
 - Run one of the following queries:  
      * mysql -u jgeis -p doh < TEDS_conversion.sql 
      * mysql -u jgeis -p doh < TEDS_DOH_conversion.sql 
 ~~

4.) No longer using crosswalk tables as that wasn't accounting for all the differences between years.  Instead, using code found 
at https://github.com/kabellhart/teds-processing/blob/main/README.md to create a csv of all the human readable translations of
the codes for each year. To do this, for each of the following python files (read_tedsa_and_tedsd_2017_19.py, read_tedsd_2006_2014.py, read_tedsd_2015_2016.py, read_tedsd_2020_2022.py):
- Edit the 'folder_path' variable to point to wherever your codebooks are.
- Go to the end of each file and make sure all the files you want processed are uncommented.
- /opt/anaconda3/bin/python3 /Users/jgeis/Work/DOH/TEDS-Processing/TEDS-D/read_tedsa_and_tedsd_2017_19.py
- /opt/anaconda3/bin/python3 /Users/jgeis/Work/DOH/TEDS-Processing/TEDS-D/read_tedsd_2006_2014.py
- /opt/anaconda3/bin/python3 /Users/jgeis/Work/DOH/TEDS-Processing/TEDS-D/read_tedsd_2015_2016.py
- /opt/anaconda3/bin/python3 /Users/jgeis/Work/DOH/TEDS-Processing/TEDS-D/read_tedsa_and_tedsd_2020_2022.py

5.) Merge all the csv results from the previous step into once csv file (merged_codes_result.csv):
- /usr/local/bin/python3 /Users/jgeis/Work/DOH/TEDS-Processing/TEDS-D/merge_codebooks.py

6.) Use the merged_codes_results.csv file to translate all the numbers in the database to human readable text.

TODO:
- Parse all the Codebooks from each year
- Merge all the results into one file, to be like teds_d_harmonization.csv, but includes all the years
- Run year_differences.py against the new TEDS_D (omit 2021)
- Compare the differences between years against the new harmonization.csv file
- Notate all the manual changes that need to be made
- Instead of running the TEDS_conversion.sql stuff, use TEDS_D_conversion.py to convert everything to text as it will handle each year independently.
Note. For the DOH part, do this up there _after_ moving the new TEDS_D table, the text version gets mangled upon import.
- Figure out how to convert 2021 to codes before moving to DOH
- Run year_differences.py again and ponder the results
- Add my contact info to readme in case anyone wants to contact me.



## Issues encountered
* From year to year the values assigned to a code change.
* The PDFs that show all the values for each code change in format from year to year, so no one parser works on them all.
* Even when parsed, there are errors, so how to find them in a massive sea of data?  A. year_differences.py
* 2021 has no codes, instead only text
* 




------
# Differences between years, TEDS-D
## 2006-2014 (no changes)
## 2015
    * AGE: Added a "1" and moved all the categories to one number less than what they were, then made 11 = "55-64" and "12" = "65 and older"
    * PREG: All male respondents were recoded to missing for this variable due to the item being not applicable. 
    * DSMCRIT: Got rid of 20 "Other Condition"
The TEDS report tables contain several variables created by combining or recoding original variables submitted by states. The following notes describe how these variables are created or recoded. 
Create a new variable that combines race and ethnicity: 
● If race is 5 White and ethnicity is 4 not of Hispanic or Latino origin or -9 missing/unknown/not collected/invalid, then change new variable to 1 non-Hispanic White; 
● if race is 4 Black or African American and ethnicity is 4 not of Hispanic or Latino origin or -9 missing/unknown/not collected/invalid, then change new variable to 2 non-Hispanic Black; 
● if ethnicity is 1, 2, 3, or 5 Hispanic or Latino origin and race is 4 Black, 5 White, 7 other single race, or -9 missing/unknown/not collected/invalid, then change new variable to 3 Hispanic; 
● if race is 1 Alaska Native, Aleut, Eskimo, 2 American Indian/Alaskan Native, 3 Asian or Pacific Islander, 6 Asian, or 9 Native Hawaiian or Other Pacific Islander and ethnicity is 4 not of Hispanic or Latino origin, then change new variable to 4 other; 
● if race is 7 other single race, or 8 two or more races and ethnicity is 4 not of Hispanic or Latino origin, then change new variable to 4 other; 
● if race is 1 Alaskan Native, Aleut, Eskimo, 2 American Indian/Alaskan Native, 3 Asian or Pacific Islander, 6 Asian, 8 two or more races, or 9 Native Hawaiian or Other Pacific Islander and ethnicity is 4 not of Hispanic or Latino origin, then change new variable to 4 other. 
Recoding for primary substance use at admission: 
● If primary substance use at admission is 2 alcohol, then change primary substance use to 1 alcohol; 
● if primary substance use at admission is 5 heroin, 6 non-prescription methadone, or 7 other opiates, then change primary substance use to 2 opiates; 
● if primary substance use at admission is 4 marijuana/hashish, then change primary substance use to 3 marijuana/hashish; 
● if primary substance use at admission is 3 cocaine/crack, then change primary substance use to 4 cocaine; 
● if primary substance use at admission is 10 methamphetamine, or 11 other amphetamines, or 12 other stimulants, then change primary substance use to 5 stimulants; 
● else if primary substance use at admission assumes any other value, then change primary substance use to -9 none/other/unknown. 
Recoding for primary substance use at discharge, as well as recoding for secondary and tertiary substance use at admission and discharge, follow the same logic as above.
Recoding service type at discharge: 
● If service type at discharge is 7 non-intensive outpatient, then service type is 10 outpatient; 
● if service type at discharge is 6 intensive outpatient, then service type is 11 intensive outpatient; 
● if service type at discharge is 4 short-term residential, then service type is 20 short-term residential; 
● if service type at discharge is 5 long-term residential, then service type is 21 long-term residential; 
● if service type at discharge is 3 hospital residential, then service type is 22 hospital residential; 
● if service type at discharge is 1 hospital detoxification, 2 free-standing detoxification, or 8 detoxification, then service type is 30 detoxification; 
● if service type at discharge is 6 intensive outpatient or 7 non-intensive outpatient and medicationassisted therapy is planned, then new service type is 40 outpatient medication-assisted opioid therapy; 
● if service type at discharge is 1 hospital detoxification, 2 free-standing detoxification, or 8 detoxification and medication-assisted therapy is planned, then new service type is 41 medicationassisted opioid detoxification; 
● else new service type is other.
## 2016: no changes from 2015
## 2017: 

## 2022:
2022: https://www.samhsa.gov/data/system/files/media-puf-file/TEDS-D-2022-DS0001-info-codebook_v1.pdf 
Recoding for primary substance use at admission: 
• If primary substance use at admission is 2 alcohol, then change primary substance use to 1 alcohol; 
• if primary substance use at admission is 5 heroin, 6 non-prescription methadone, or 7 other opiates, then change primary substance use to 2 opiates; 
• if primary substance use at admission is 4 marijuana/hashish, then change primary substance use to 3 marijuana/hashish; 
• if primary substance use at admission is 3 cocaine/crack, then change primary substance use to 4 cocaine; 
• if primary substance use at admission is 10 methamphetamine/speed, or 11 other amphetamines, or 12 other stimulants, then change primary substance use to 5 stimulants; 
• else if primary substance use at admission assumes any other value, then change primary substance use to -9 none/other/unknown. Recoding for primary substance use at discharge, as well as recoding for secondary and tertiary substance use at admission and discharge, follow the same logic as above. Recoding service type at discharge: 
• If service type at discharge is 7 non-intensive outpatient, then service type is 10 outpatient; 
• if service type at discharge is 6 intensive outpatient, then service type is 11 intensive outpatient; 
• if service type at discharge is 4 short-term residential, then service type is 20 short-term residential; 
• if service type at discharge is 5 long-term residential, then service type is 21 long-term residential; 
• if service type at discharge is 3 hospital residential, then service type is 22 hospital residential; 
• if service type at discharge is 1 hospital detoxification, 2 free-standing detoxification, or 8 detoxification, then service type is 30 detoxification; 
• if service type at discharge is 6 intensive outpatient or 7 non-intensive outpatient and medication-assisted therapy is planned, then new service type is 40 outpatient medicationassisted opioid therapy; C-1 
• if service type at discharge is 1 hospital detoxification, 2 free-standing detoxification, or 8 detoxification and medication-assisted therapy is planned, then new service type is 41 medication-assisted opioid detoxification; 
• else new service type is other.

[Codebooks and Data](https://www.samhsa.gov/data/data-we-collect/teds/datafiles)
- [SAMHSA TEDS D 2006-2014 codebook](https://www.samhsa.gov/data/system/files/media-puf-file/TEDS-D-2006-2014-DS0001-info-codebook.pdf)
- [SAMHSA TEDS D 2015 codebook](https://www.samhsa.gov/data/system/files/media-puf-file/TEDS-D-2015-DS0001-info-codebook.pdf)
- [SAMHSA TEDS D 2016 codebook](https://www.samhsa.gov/data/system/files/media-puf-file/TEDS-D-2016-DS0001-info-codebook.pdf)
- [SAMHSA TEDS D 2017 codebook](https://www.samhsa.gov/data/system/files/media-puf-file/TEDS-D-2017-DS0001-info-codebook.pdf)
- [SAMHSA TEDS D 2018 codebook](https://www.samhsa.gov/data/system/files/media-puf-file/TEDS-D-2018-DS0001-info-codebook.pdf)
- [SAMHSA TEDS D 2019 codebook](https://www.samhsa.gov/data/system/files/media-puf-file/TEDS-D-2019-DS0001-info-codebook_V1.pdf)
- [SAMHSA TEDS D 2020 codebook](https://www.samhsa.gov/data/system/files/media-puf-file/TEDS-D-2020-DS0001-info-codebook.pdf)
- [SAMHSA TEDS D 2021 codebook](https://www.samhsa.gov/data/system/files/media-puf-file/TEDS-D-2021-DS0001-info-codebook.pdf)
- [SAMHSA TEDS D 2022 codebook](https://www.samhsa.gov/data/system/files/media-puf-file/TEDS-D-2022-DS0001-info-codebook_v1.pdf)

Found a listing of changes on page 20 in the "manual" https://www.samhsa.gov/data/sites/default/files/reports/rpt38667/combined-su-and-mh-state-manual.pdf 