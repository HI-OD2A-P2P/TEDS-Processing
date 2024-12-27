# reads in pdf files specified at the bottom of the file and extracts the 
# code, value, and label columns and writes it out to a csv file.

import slate3k as slate
import numpy as np
import re
import pandas as pd

# To run:
# /opt/anaconda3/bin/python3 /Users/jgeis/Work/DOH/TEDS-Processing/TEDS-D/read_tedsd_2006_2014.py

# code gotten from https://github.com/kabellhart/teds-processing/blob/main/README.md 


# define regex patterns to look for above and below tables

header = re.compile(r'[A-Z0-9_]+: [A-Z].*\n([a-z0-9].*)*')
header_end = re.compile(r'[a-z]')

table_start = re.compile(r'F[\n]*r[\n]*e[\n]*q[\n]*u[\n]*e[\n]*n[\n]*c[\n]*y\n%\n')
table_end = re.compile('\nT[\n]*o[\n]*t[\n]*a[\n]*l[\n]*')

def isnumeric(x):
    return x.isnumeric()


# read in a PDF
def read_pdf(filename):
    global pdfFileObj, pdfReader, npages
    pdfFileObj = open(filename, 'rb')
    extracted_text = slate.PDF(pdfFileObj)
    npages = len(extracted_text)
    dfs = []
    for page in range(npages):
        
        result = read_page(extracted_text[page])
        if result:
            (code, label), df = result
            code = code.strip().replace('\n', ' ')
            label = label.strip().replace('\n', ' ')
            if code == "SERVSETD":  
                code = "SERVICES_D"
            if df is not None:
                df['code'] = code
                df['full_label'] = label
                # Filter out rows with code 'PMSA'
                df = df[df['code'] != 'PMSA'] 
                # Filter out rows with code 'CBSA'
                df = df[df['code'] != 'CBSA'] 
                # Filter out rows with code 'STFIPS'
                #df = df[df['code'] != 'STFIPS'] 
                dfs.append(df)
            else:
                dfs.append(pd.DataFrame.from_dict({'code': [code], 'full_label': [label]}))

    pd.concat(dfs).to_csv(filename[:-4] + '_codes.csv')

flags = ('Value', 'Label', 'Unweighted\nFrequency', '%')
def remove_extras(some_list):
    i = 0
    while i < len(some_list):
        item = some_list[i]
        if item in flags:
            some_list.pop(i)
            continue
        if len(item) < 5:
            i += 1
            
        else:
            if item[-3:] == 'xoc' or item[:5] == '• Min' or item[:5] == '• Max' \
               or item[:5] == 'Width' or item[:5] == 'Varia':
                some_list.pop(i)
            elif len(item) > 10 and item[:11] == 'Please note':
                some_list.pop(i)
            elif item[0] == '•': # pop everything until the next flag
                while some_list[i] not in flags and i < len(some_list):
                    some_list.pop(i)
                
            else:
                i += 1
    some_list.pop(-1)            

{'Value': 'short', 'Label': 'long', 'Unweighted\nFrequency': 'long', '%': 'long'}            

def read_page(text):
    #print("text: ", text)
    first_lowercase = re.search(header_end, text)
    if first_lowercase:
        first_lowercase = first_lowercase.span()[0]
    else:
        return None
    header_text = text[:first_lowercase-1]
    
    if ':' not in header_text or len(header_text) > 200:
        return None
    header_text = header_text.split('\n')[0]
    #print("header_text: ", header_text)

    entries = text.split('\n\n')
    #print("entries: ", entries)

    if 'Value' not in entries or 'Label' not in entries:
        return header_text.split(':'), None
    
    content_start = min([entries.index(i) for i in flags])
    entries = entries[content_start:]
    pad = True
    if 'Total' not in entries:
        pad = False
    remove_extras(entries)
    n_entries = len(entries)
    if n_entries < 5:
        return header_text.split(':'), None                     
    #print("entries: ", entries)

    colways_votes = []
    if n_entries > 5:
        for i in range(3, n_entries, 4):
            if '%' not in entries[i]:
                colways_votes.append(1)
            else:
                colways_votes.append(0)
    colways = round(sum(colways_votes) / len(colways_votes))
    if pad and colways:
        n_rows = int((n_entries + 1) / 4)
        entries.insert(n_rows-1, '')
        
    elif pad:
        entries.insert(-4, '')
        
        n_rows = int((n_entries+1) / 4)
    else:
        n_rows = int((n_entries) / 4)
    if colways:
        entries_grid = np.reshape(entries, (4, n_rows))
        
        entries_grid = np.flip(np.rot90(entries_grid, k=1), axis=0)
        
    else:
        entries_grid = np.reshape(entries, (n_rows, 4))

    # remove all records that have an empty 'Value' column entry
    i = 0
    while i < entries_grid.shape[0]:
        if entries_grid[i, 0] == '' or len(entries_grid[i, 0].strip()) == 0:
            #print("deleting: ", entries_grid[i])
            entries_grid = np.delete(entries_grid, i, axis=0) 
            i -= 1  # Decrement i to avoid skipping a row after deletion
        i += 1 

    # Manual corrections where code = 'LOS' and bad values
    if header_text == "LOS: LENGTH OF STAY":
        #print("entries_grid: ", entries_grid)
        #for i in range(entries_grid.shape[0]):
        i = 0;
        while i < entries_grid.shape[0]:
            #print("entries_grid[",i,", 1]: ", entries_grid[i, 0])
            if entries_grid[i, 0] == '81,108':
                entries_grid[i, 0] = '25'  # update Value
                entries_grid[i, 1] = '25'  # Update Label
            elif entries_grid[i, 0] == '82,801':
                entries_grid[i, 0] = '26' 
                entries_grid[i, 1] = '26'  
            elif entries_grid[i, 0] == '137,928':
                entries_grid[i, 0] = '27' 
                entries_grid[i, 1] = '27'  
            elif entries_grid[i, 0] == '252,950':
                entries_grid[i, 0] = '28' 
                entries_grid[i, 1] = '28' 
            elif entries_grid[i, 0] == '176,000':
                entries_grid[i, 0] = '29' 
                entries_grid[i, 1] = '29'  
            elif entries_grid[i, 0] == '153,474':
                entries_grid[i, 0] = '30' 
                entries_grid[i, 1] = '30'  
            elif entries_grid[i, 0] == '1,069,634':
                entries_grid[i, 0] = '31' 
                entries_grid[i, 1] = '31 TO 45 DAYS'
            elif entries_grid[i, 0] == '831,506':
                entries_grid[i, 0] = '32' 
                entries_grid[i, 1] = '46 TO 60 DAYS'  
            elif entries_grid[i, 0] == '1,360,845':
                entries_grid[i, 0] = '33' 
                entries_grid[i, 1] = '61 TO 90 DAYS'
            elif entries_grid[i, 0] == '1,105,033':
                entries_grid[i, 0] = '34' 
                entries_grid[i, 1] = '91 TO 120 DAYS'
            elif entries_grid[i, 0] == '1,308,945':
                entries_grid[i, 0] = '35' 
                entries_grid[i, 1] = '121 TO 180 DAYS'
            elif entries_grid[i, 0] == '1,443,966':
                entries_grid[i, 0] = '36' 
                entries_grid[i, 1] = '181 TO 365 DAYS'
            elif entries_grid[i, 0] == '668,075':
                entries_grid[i, 0] = '37' 
                entries_grid[i, 1] = 'MORE THAN A YEAR'
            elif entries_grid[i, 0] == '133': 
                entries_grid = np.delete(entries_grid, i, axis=0) 
                i -= 1 # Decrement i to avoid skipping a row after deletion
            elif entries_grid[i, 0] == '': 
                entries_grid = np.delete(entries_grid, i, axis=0) 
                i -= 1  # Decrement i to avoid skipping a row after deletion
            i += 1 

    # Manual corrections where code = 'DAYWAIT' and bad values
    if header_text == "DAYWAIT: DAYS WAITING TO ENTER TREATMENT":
        #print("entries_grid: ", entries_grid)
        #for i in range(entries_grid.shape[0]):
        i = 0;
        while i < entries_grid.shape[0]:
            #print("entries_grid[",i,", 0]: ", entries_grid[i, 0], ", entries_grid[",i,", 1]: ", entries_grid[i, 1])
            if entries_grid[i, 0] == '34' and entries_grid[i, 1] == '36':
                entries_grid[i, 1] = '34'
            elif entries_grid[i, 0] == '35' and entries_grid[i, 1] == '37':
                entries_grid[i, 1] = '35'  
            elif entries_grid[i, 0] == '36':
                entries_grid[i, 1] = '36'  
            elif entries_grid[i, 0] == '37':
                entries_grid[i, 1] = '37' 
            elif entries_grid[i, 0] == '38':
                entries_grid[i, 1] = '38' 
            elif entries_grid[i, 0] == '39':
                entries_grid[i, 1] = '39' 
            elif entries_grid[i, 0] == '40':
                entries_grid[i, 1] = '40' 
            elif entries_grid[i, 0] == '41':
                entries_grid[i, 1] = '41'   
            elif entries_grid[i, 0] == '42':
                entries_grid[i, 1] = '42' 
            elif entries_grid[i, 0] == '43':
                entries_grid[i, 1] = '43' 
            elif entries_grid[i, 0] == '44':
                entries_grid[i, 1] = '44' 
            elif entries_grid[i, 0] == '45':
                entries_grid[i, 1] = '45' 
            elif entries_grid[i, 0] == '46':
                entries_grid[i, 1] = '46' 
            elif entries_grid[i, 0] == '47':
                entries_grid[i, 1] = '47' 
            elif entries_grid[i, 0] == '48':
                entries_grid[i, 1] = '48' 
            elif entries_grid[i, 0] == '49':
                entries_grid[i, 1] = '49' 
            elif entries_grid[i, 0] == '34' and entries_grid[i, 1] == '10,088':
                entries_grid = np.delete(entries_grid, i, axis=0) 
                i -= 1 # Decrement i to avoid skipping a row after deletion
            elif entries_grid[i, 0] == '35' and entries_grid[i, 1] == '13,607':
                entries_grid = np.delete(entries_grid, i, axis=0) 
                i -= 1  # Decrement i to avoid skipping a row after deletion

                # adding missing rows here instead of outside the loop because DAYWAIT runs over two separate pages
                # so it would get executed twice.  This way, it appears at the end of all the DAYWAITS
                new_row = ['X', 'OTHER DAYWAIT CATEGORIES NOT PRINTED HERE', '', '']
                entries_grid = np.append(entries_grid, [new_row], axis=0)
                new_row = ['-9', 'MISSING/UNKNOWN/NOT COLLECTED/INVALID', '', '']
                entries_grid = np.append(entries_grid, [new_row], axis=0)
                i += 2
            i += 1 

    if header_text == "REASON: REASON FOR DISCHARGE":
        i = 0
        while i < entries_grid.shape[0]:
            #print("entries_grid[",i,", 0]: ", entries_grid[i, 0], ", entries_grid[",i,", 1]: ", entries_grid[i, 1])
            if entries_grid[i, 0] == '1':
                entries_grid[i, 1] = 'Treatment Completed'
            elif entries_grid[i, 0] == '2':
                entries_grid[i, 1] = 'Left Against Professional Advice'
            elif entries_grid[i, 0] == '3':
                entries_grid[i, 1] = 'Terminated By Facility'
            elif entries_grid[i, 0] == '4':
                entries_grid[i, 1] = 'Transferred To Another Treatment Program Or Facility'
            elif entries_grid[i, 0] == '5':
                entries_grid[i, 1] = 'Incarcerated'
            elif entries_grid[i, 0] == '6':
                entries_grid[i, 1] = 'Death'
            elif entries_grid[i, 0] == '7':
                entries_grid[i, 1] = 'Other'
            elif entries_grid[i, 0] == 'TREATMENT COMPLETED':
                entries_grid[i, 0] = '-9'
                entries_grid[i, 1] = 'Missing/Unknown/Not Collected/Invalid'
            i += 1 

    if header_text == "PRIMPAY: EXPECTED/ACTUAL PRIMARY SOURCE OF PAYMENT":
        i = 0
        while i < entries_grid.shape[0]:
            #print("entries_grid[",i,", 0]: ", entries_grid[i, 0], ", entries_grid[",i,", 1]: ", entries_grid[i, 1])
            if entries_grid[i, 0] == '1':
                entries_grid[i, 1] = 'Self-Pay'
            elif entries_grid[i, 0] == '2':
                entries_grid[i, 1] = 'Blue Cross/Blue Shield, Other Health Insurance Companies'
            elif entries_grid[i, 0] == '3':
                entries_grid[i, 1] = 'Medicare, Workers Compensation'
            elif entries_grid[i, 0] == '4':
                entries_grid[i, 1] = 'Medicaid'
            elif entries_grid[i, 0] == '5':
                entries_grid[i, 1] = 'Other Government Payments'
            elif entries_grid[i, 0] == '8':
                entries_grid[i, 1] = 'No Charge (Free, Charity, Special Research, Teaching)'
            elif entries_grid[i, 0] == '9':
                entries_grid[i, 1] = 'Other'
            elif entries_grid[i, 0] == 'SELF-PAY':
                entries_grid[i, 0] = '-9'
                entries_grid[i, 1] = 'Missing/Unknown/Not Collected/Invalid'
            i += 1 
    
    if header_text == "SERVSETD: SERVICE SETTING AT DISCHARGE":
        i = 0
        while i < entries_grid.shape[0]:
            #print("entries_grid[",i,", 0]: ", entries_grid[i, 0], ", entries_grid[",i,", 1]: ", entries_grid[i, 1])
            if entries_grid[i, 0] == '1':
                entries_grid[i, 1] = 'DETOX, 24 HR, HOSPITAL INPATIENT'
            elif entries_grid[i, 0] == '2':
                entries_grid[i, 1] = 'DETOX, 24 HR, FREE-STANDING RESIDENTIAL'
            elif entries_grid[i, 0] == '3':
                entries_grid[i, 1] = 'REHAB/RES, HOSPITAL (NON-DETOX)'
            elif entries_grid[i, 0] == '4':
                entries_grid[i, 1] = 'REHAB/RES, SHORT TERM (30 DAYS OR FEWER)'
            elif entries_grid[i, 0] == '5':
                entries_grid[i, 1] = 'REHAB/RES, LONG TERM (MORE THAN 30 DAYS)'
            elif entries_grid[i, 0] == '6':
                entries_grid[i, 1] = 'AMBULATORY, INTENSIVE OUTPATIENT'
            elif entries_grid[i, 0] == '7':
                entries_grid[i, 1] = 'AMBULATORY, NON-INTENSIVE OUTPATIENT'
            elif entries_grid[i, 0] == '8':
                entries_grid[i, 1] = 'AMBULATORY, DETOXIFICATION'   
            elif entries_grid[i, 0] == 'DETOX, 24 HR, HOSPITAL INPATIENT':
                entries_grid[i, 0] = '-9'
                entries_grid[i, 1] = 'Missing/Unknown/Not Collected/Invalid'
            i += 1 

    # format years from something like '12-14' to match other years like '12 To 14 Years' 
    if header_text.startswith('FRSTUSE'):
        #print("entries_grid: ", entries_grid)
        #for i in range(entries_grid.shape[0]):
        i = 0
        while i < entries_grid.shape[0]:
            #print("entries_grid[",i,", 1]: ", entries_grid[i, 0])
            match = re.match(r"(\d+)-(\d+)", entries_grid[i, 1])
            if match:
                start, end = match.groups()
                entries_grid[i, 1] = f"{start} to {end} years"
            i += 1

    if header_text == "PSOURCE: PRINCIPAL SOURCE OF REFERRAL":
        #print("entries_grid: ", entries_grid)
        #for i in range(entries_grid.shape[0]):
        i = 0
        while i < entries_grid.shape[0]:
            #print("entries_grid[",i,", 1]: ", entries_grid[i, 0])
            if entries_grid[i, 0] == '1':
                entries_grid[i, 1] = 'INDIVIDUAL (INCLUDES SELF-REFERRAL)'
            elif entries_grid[i, 0] == '2':
                entries_grid[i, 1] = 'ALCOHOL/DRUG ABUSE CARE PROVIDER'
            elif entries_grid[i, 0] == '3':
                entries_grid[i, 1] = 'OTHER HEALTH CARE PROVIDER'
            elif entries_grid[i, 0] == '4':
                entries_grid[i, 1] = 'SCHOOL (EDUCATIONAL)'
            elif entries_grid[i, 0] == '5':
                entries_grid[i, 1] = 'EMPLOYER/EAP'
            elif entries_grid[i, 0] == '6':
                entries_grid[i, 1] = 'OTHER COMMUNITY REFERRAL'
            elif entries_grid[i, 0] == '7':
                entries_grid[i, 1] = 'COURT/CRIMINAL JUSTICE REFERRAL / DUI / DWI'  # Update Label
            elif entries_grid[i, 0] == 'INDIVIDUAL (INCLUDES SELF-REFERRAL)':
                entries_grid[i, 0] = '-9'
            i += 1 
        #new_row = ['-9', 'MISSING/UNKNOWN/NOT COLLECTED/INVALID', '', '']
        #print("executed")
        #entries_grid = np.append(entries_grid, [new_row], axis=0)


    #print("entries: ", entries_grid)
    df = pd.DataFrame(entries_grid,
                  columns=['Value', 'Label', 'Frequency', 'Percent'])
    
    return header_text.split(':'), df

folder_path = "/Users/jgeis/Work/DOH/TEDS-Processing/TEDS-D/codebooks/"
read_pdf(f"{folder_path}TEDS-D-2006-2014-DS0001-info-codebook.pdf")
