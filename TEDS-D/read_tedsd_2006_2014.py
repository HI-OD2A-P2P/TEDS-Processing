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

    # Manual corrections where code = 'LOS' and bad values
    if header_text == "LOS: LENGTH OF STAY":
        print("entries_grid: ", entries_grid)
        
        #for i in range(entries_grid.shape[0]):
        i = 0;
        while i < entries_grid.shape[0]:
            print('i: ', i)
            print("entries_grid[",i,", 1]: ", entries_grid[i, 0])
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

    df = pd.DataFrame(entries_grid,
                  columns=['Value', 'Label', 'Frequency', 'Percent'])
    
    return header_text.split(':'), df

folder_path = "/Users/jgeis/Work/DOH/TEDS-Processing/TEDS-D/codebooks/"
read_pdf(f"{folder_path}TEDS-D-2006-2014-DS0001-info-codebook.pdf")
