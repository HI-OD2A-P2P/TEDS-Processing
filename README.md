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

1.) Download and unzip the following into TEDS-A/csv_files: (links are found at [SAMHSA TEDS](https://www.samhsa.gov/data/data-we-collect/teds/datafiles?data_collection=1011)):
- [SAMHSA TEDS A 2000-2021 data](https://www.samhsa.gov/data/system/files/media-puf-file/TEDS-A-2000_2021-DS0001-bndl-data-csv.zip)
- [SAMHSA TEDS A 2000-2021 codebook](https://www.samhsa.gov/data/system/files/media-puf-file/TEDS-A-2000-2021-DS0001-info-codebook.pdf)
- [SAMHSA TEDS A 2022 data](https://www.samhsa.gov/data/system/files/media-puf-file/TEDS-A-2022-DS0001-bndl-data-csv_v1.zip)
- [SAMHSA TEDS A 2022 codebook](https://www.samhsa.gov/data/system/files/media-puf-file/TEDS-A-2022-DS0001-info-codebook_v1.pdf)
- 2022 was the last year available as of Jan 17, 2025, if there are any subsequent years added, get those and then add their links here.

2.) Merge the above csv files into one file:
 - Open the LoadData_TEDS_A.py file
 - Edit the credentials_local.json and/or credentials_remote.json files as appropriate.
 - Edit the LoadData_TEDS_A.py to point at the desired credential file and make sure test_mode variable is set to "False"
 - Uncomment the "“combine_csv_files”" method call line at the bottom of the file and comment out the "convert_to_db" method call.
 - The code is currently stripping out all states that are not Hawaii, so the resulting csv file will be significantly smaller than the input files.
 - Run the “combine_csv_files” method to put the above csv files into one file:  
 /usr/local/bin/python3 /Users/jgeis/Work/DOH/TEDS-Processing/TEDS-A/LoadData_TEDS_A.py

3.) Load the data from the newly created csv file into a database table (will still be numeric, you can delete this later if you want):
 - Mysql Version
     * Open the LoadData_TEDS_A.py file
      * Edit the credentials_local.json and/or credentials_remote.json files as appropriate.
      * Edit the LoadData_TEDS_A.py to point at the desired credential file and make sure test_mode variable is set to "False"
      * Uncomment the "convert_to_db" method call line at the bottom of the file and comment out the "combine_csv_files" method call.
      * Run the "convert_to_db" method to read the csv and put it all into a mysql table:   /usr/local/bin/python3 /Users/jgeis/Work/DOH/TEDS-Processing/TEDS-A/LoadData_TEDS_A.py
 - MSSQL Version: Unfortunately, I never got the code to run, the driver that writes out to the database was giving an error that basically said "hey, the issue isn't me" and I was unable to find a solution in the time given.  Instead, we just did a direct import of the csv file from step 2 into the database.  The process for that is as follows:
      * If using a local machine to a VM, to copy the csv file over: go into finder, and do a copy on the csv file, then go to finder in the VM and do a paste.
      * Open MS SQL Management Studio    
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


4.) No longer using crosswalk tables as that wasn't accounting for all the differences between years.  Instead, using code found 
at https://github.com/kabellhart/teds-processing/blob/main/README.md to create a csv of all the human readable translations of
the codes for each year. To do this, in TEDS_D/read_tedsd_2020_2022.py:  
- Edit the 'folder_path' variable to point to wherever your codebooks are.  
- Go to the end of each file and make sure all the files you want processed are uncommented.  
- /opt/anaconda3/bin/python3 /Users/jgeis/Work/DOH/TEDS-Processing/TEDS-D/read_tedsd_2020_2022.py  
The output file(s) will show up in TEDS_A/codebooks as csv files  

5.) Merge all the csv results from the previous step into once csv file (merged_codes_result.csv):  
- /usr/local/bin/python3 /Users/jgeis/Work/DOH/TEDS-Processing/TEDS-D/merge_codebooks.py  

6.) Mssql/DOH only: Copy still-encoded data up to DOH and import into MSSQL.  We have to import it to 
mssql still encoded because the text version gets mangled upon import.  
- Export local TEDS_D database to csv via MySQLWorkbench (make sure to select ',' as the delimiter and get rid of the " around strings setting)  
- Copy the resulting csv file, go to finder on remote machine and paste it there.  
- Follow the process listed in step 3 above to import the data to mssql  
- Run the following commands there:  
   ALTER TABLE dbo.TEDS_A ALTER COLUMN ROUTE3 VARCHAR(80);   
   ALTER TABLE dbo.TEDS_A ALTER COLUMN ROUTE2 VARCHAR(80);   
   ALTER TABLE dbo.TEDS_A ALTER COLUMN ROUTE1 VARCHAR(80);   
   ALTER TABLE dbo.TEDS_A ALTER COLUMN PRIMPAY VARCHAR(100);   
   ALTER TABLE dbo.TEDS_A ALTER COLUMN EDUC VARCHAR(90);   
   ALTER TABLE dbo.TEDS_A ALTER COLUMN DSMCRIT VARCHAR(80);   
 
7.) MySQL/Local only: Use the merged_codes_results.csv file to translate all the numbers in the database to human readable text.  
- /usr/local/bin/python3 /Users/jgeis/Work/DOH/TEDS-Processing/TEDS-A/TEDS_A_conversion.py > output.sql
- mysql -u jgeis -p doh < output.sql

8.) Mssql/DOH only: Use the merged_codes_results.csv file to translate all the numbers in the database to human readable text. 
- /usr/local/bin/python3 /Users/jgeis/Work/DOH/TEDS-Processing/TEDS-A/TEDS_A_conversion.py > output.sql
- Copy output.sql up to DOH server.
- Open output.sql in MSSQL and execute it.  Takes about 30 minutes.

9.) Update the column names by running the commands in either TEDS_A/ModifyColumnNamesMssql.sql or TEDS_A/ModifyColumnNamesMysql.sql, depending on which db you are on.

10.) Mssql/DOH only: This is for UH PowerBI stuff only, doesn't pertain to anyone else who might happen to use this.
CREATE VIEW dbo.teds_a_data_view AS  
select distinct  
Caseid,  
AgeAtAdmission,  
YearOfAdmission,  
Gender,  
SubstanceUsePrimary,  
SubstanceUseSecondary,  
SubstanceUseTertiary,  
CASE  
WHEN SubstanceUsePrimary = '' Then 0  
WHEN SubstanceUseSecondary = '' THEN 1  
WHEN SubstanceUseTertiary = '' THEN 2  
Else 3  
END as num_substances  
from dbo.TEDS_A;  

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
      * Open MS SQL Management Studio      
      * double click on the database to show the popup menu
      * select 'Tasks'
      * select 'Import Data', do NOT select "Import flat file", it will fail
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

6.) For DOH only: Run TEDS_D_reverse_conversion.py to convert 2021 to codes instead of human readable.  It's the 
only one with text.  It's the import into mssql with the values being text that's messing things up.  Particularly 
that the values have commas in them, even though they are surrounded by quotes.  This would likely have been 
handled nicely if I could import an excel file, but the system doesn't have the driver for it and as the files 
aren't small, I'm concerned about overwhelming the already scarce disk space.  Other folks 
won't need to do this, but text gets mangles when I move it over to DOH, so I need to convert everything to codes,
move it to DOH, and then run the script to convert everything to human readable once it's already in the database.  
- /usr/local/bin/python3 /Users/jgeis/Work/DOH/TEDS-Processing/TEDS-D/TEDS_D_reverse_conversion.py > reverse_output.sql  
- mysql -u jgeis -p doh < reverse_output.sql  

7.) Mssql/DOH only: Copy still-encoded data up to DOH and import into MSSQL.  We have to import it to 
mssql still encoded because the text version gets mangled upon import.  
- Export local TEDS_D database to csv via MySQLWorkbench (make sure to select ',' as the delimiter and get rid of the " around strings setting)  
- Copy the resulting csv file, go to finder on remote machine and paste it there.  
- Follow the process listed in step 3 above to import the data to mssql  
- Run the following commands there:  
  ALTER TABLE dbo.TEDS_D ALTER COLUMN ROUTE3 VARCHAR(80);   
  ALTER TABLE dbo.TEDS_D ALTER COLUMN ROUTE2 VARCHAR(80);   
  ALTER TABLE dbo.TEDS_D ALTER COLUMN ROUTE1 VARCHAR(80);   
  ALTER TABLE dbo.TEDS_D ALTER COLUMN REASON VARCHAR(70);   
  ALTER TABLE dbo.TEDS_D ALTER COLUMN PRIMPAY VARCHAR(100);   
  ALTER TABLE dbo.TEDS_D ALTER COLUMN EDUC VARCHAR(90);   
  ALTER TABLE dbo.TEDS_D ALTER COLUMN DSMCRIT VARCHAR(80);   

8.) MySQL/Local only: Use the merged_codes_results.csv file to translate all the numbers in the database to human readable text.  
- /usr/local/bin/python3 /Users/jgeis/Work/DOH/TEDS-Processing/TEDS-D/TEDS_D_conversion.py > output.sql
- mysql -u jgeis -p doh < output.sql

9.) Mssql/DOH only: Use the merged_codes_results.csv file to translate all the numbers in the database to human readable text. 
- /usr/local/bin/python3 /Users/jgeis/Work/DOH/TEDS-Processing/TEDS-D/TEDS_D_conversion.py > output.sql
- Copy output.sql up to DOH server.
- Open output.sql in MSSQL and execute it.  Takes about 30 minutes.

10.) Update the column names by running the commands in either TEDS_D/ModifyColumnNamesMssql.sql or TEDS_D/ModifyColumnNamesMysql.sql, depending on which db you are on.

11.) Fix cases where data doesn't match exactly:
- update dbo.TEDS_D set AgeAtAdmission = '12-14 Years Old' where AgeAtAdmission = '12-14' or AgeAtAdmission = '12-14 Years';  
- update dbo.TEDS_D set AgeAtAdmission = '15-17 Years Old' where AgeAtAdmission = '15-17' or AgeAtAdmission = '15-17 Years';  
- update dbo.TEDS_D set AgeAtAdmission = '18-20 Years Old' where AgeAtAdmission = '18-20' or AgeAtAdmission = '18-20 Years';  
- update dbo.TEDS_D set AgeAtAdmission = '21-24 Years Old' where AgeAtAdmission = '21-24' or AgeAtAdmission = '21-24 Years';  
- update dbo.TEDS_D set AgeAtAdmission = '25-29 Years Old' where AgeAtAdmission = '25-29' or AgeAtAdmission = '25-29 Years';  
- update dbo.TEDS_D set AgeAtAdmission = '30-34 Years Old' where AgeAtAdmission = '30-34' or AgeAtAdmission = '30-34 Years';  
- update dbo.TEDS_D set AgeAtAdmission = '35-39 Years Old' where AgeAtAdmission = '35-39' or AgeAtAdmission = '35-39 Years';  
- update dbo.TEDS_D set AgeAtAdmission = '40-44 Years Old' where AgeAtAdmission = '40-44' or AgeAtAdmission = '40-44 Years';  
- update dbo.TEDS_D set AgeAtAdmission = '45-49 Years Old' where AgeAtAdmission = '45-49' or AgeAtAdmission = '45-49 Years';  
- update dbo.TEDS_D set AgeAtAdmission = '50-54 Years Old' where AgeAtAdmission = '50-54' or AgeAtAdmission = '50-54 Years';  
- update dbo.TEDS_D set AgeAtAdmission = '55-64 Years Old' where AgeAtAdmission = '55-64' or AgeAtAdmission = '55-64 Years';  
- update dbo.TEDS_D set AgeAtAdmission = '65 Years And Older' where AgeAtAdmission = '65 And Older';
- update dbo.TEDS_D set SubstanceUsePrimary = 'Over-The-Counter Medications' where SubstanceUsePrimary = 'Overthecounter Medications';  
- update dbo.TEDS_D set SubstanceUseSecondary = 'Over-The-Counter Medications' where SubstanceUseSecondary = 'Overthecounter Medications';  
- update dbo.TEDS_D set SubstanceUseTertiary = 'Over-The-Counter Medications' where SubstanceUseTertiary = 'Overthecounter Medications';  
- update dbo.TEDS_D set SubstanceUsePrimary = 'Non-Prescription Methadone' where SubstanceUsePrimary = 'Nonprescription Methadone';  
- update dbo.TEDS_D set SubstanceUseSecondary = 'Non-Prescription Methadone' where SubstanceUseSecondary = 'Nonprescription Methadone';  
- update dbo.TEDS_D set SubstanceUseTertiary = 'Non-Prescription Methadone' where SubstanceUseTertiary = 'Nonprescription Methadone';    
- update dbo.TEDS_D set SubstanceUsePrimary = 'Methamphetamine/Speed' where SubstanceUsePrimary = 'Methamphetamine';  
- update dbo.TEDS_D set SubstanceUseSecondary = 'Methamphetamine/Speed' where SubstanceUseSecondary = 'Methamphetamine';  
- update dbo.TEDS_D set SubstanceUseTertiary = 'Methamphetamine/Speed' where SubstanceUseTertiary = 'Methamphetamine';  


12.) Mssql/DOH only: This is for UH PowerBI stuff only, doesn't pertain to anyone else who might happen to use this.
CREATE VIEW dbo.teds_d_data_view AS  
select distinct  
Caseid,  
AgeAtAdmission,  
YearOfDischarge,  
Gender,  
SubstanceUsePrimary,  
SubstanceUseSecondary,  
SubstanceUseTertiary,  
CASE  
WHEN SubstanceUsePrimary = 'None' Then 0  
WHEN SubstanceUseSecondary = 'None' THEN 1  
WHEN SubstanceUseTertiary = 'None' THEN 2  
Else 3  
END as num_substances  
from dbo.TEDS_D;  




## Issues encountered
* From year to year the values assigned to a code change.
* The PDFs that show all the values for each code change in format from year to year, so no one parser works on them all.
* Even when parsed, there are errors, so how to find them in a massive sea of data?  A. year_differences.py
* 2021 has no codes, instead only text
* 

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