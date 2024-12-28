# reads in pdf files specified at the bottom of the file and extracts the 
# code, value, and label columns and writes it out to a csv file.

import PyPDF4
import numpy as np
import re
import pandas as pd

# to run:
# /opt/anaconda3/bin/python3 /Users/jgeis/Work/DOH/TEDS-Processing/TEDS-D/read_tedsd_2015_2016.py

# adjust for TEDS-D 2016

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
    
    pdfReader = PyPDF4.PdfFileReader(pdfFileObj)
    npages = pdfReader.numPages
    dfs = []
    for page in range(npages):
        result = read_page(page)
        #print("result: ", result)
        if result:
            (code, label), df = result
            code = code.strip().replace('\n', ' ')
            label = label.strip().replace('\n', ' ')
            if code == "`  SERVICES_D":  # the PDF has a typo, get rid of it
                code = "SERVICES_D"
            if code == "ETHNICITY":  # for 2016, 2015 is already fixed below
                code = "ETHNIC"
            if df is not None:
                df['code'] = code
                df['full_label'] = label
                dfs.append(df)
                #print("df1: ", dfs)
            else:
                #print("df from dict: ", pd.DataFrame.from_dict({'code': [code], 'full_label': [label]}))
                dfs.append(pd.DataFrame.from_dict({'code': [code], 'full_label': [label]}))
    
    # the page that had this data was completely absent in the text output, so I made it manually
    # only want this to run once per year, so make sure we check the year in the filename
    if ("2015" in filename):
        data = [{'code': 'IDU', 'full_label': 'CURRENT IV DRUG USE REPORTED AT ADMISSION', 'Value': '0', 'Label':'IDU NOT REPORTED'},
                {'code': 'IDU', 'full_label': 'CURRENT IV DRUG USE REPORTED AT ADMISSION', 'Value': '1', 'Label':'IDU REPORTED'},
                {'code': 'IDU', 'full_label': 'CURRENT IV DRUG USE REPORTED AT ADMISSION', 'Value': '-9', 'Label':'NO SUBSTANCES REPORTED'}]
        dfs.append(pd.DataFrame(data))
    if ("2016" in filename):
        data = [{'code': 'IDU', 'full_label': 'CURRENT IV DRUG USE REPORTED AT ADMISSION', 'Value': '0', 'Label':'IDU NOT REPORTED'},
                {'code': 'IDU', 'full_label': 'CURRENT IV DRUG USE REPORTED AT ADMISSION', 'Value': '1', 'Label':'IDU REPORTED'},
                {'code': 'IDU', 'full_label': 'CURRENT IV DRUG USE REPORTED AT ADMISSION', 'Value': '-9', 'Label':'NO SUBSTANCES REPORTED'}]
        dfs.append(pd.DataFrame(data))

    #print("dfs3: ", dfs)
    pd.concat(dfs).to_csv(filename[:-4] + '_codes.csv')

def read_page(page_num):
    pageObj = pdfReader.getPage(page_num)
    text = pageObj.extractText()
    print("PAGE: ", page_num)
    print("text: ", text)
    print("header: ", header)

    first_lowercase = re.search(header_end, text)
    if first_lowercase:
        first_lowercase = first_lowercase.span()[0]
    else:
        return None
    header_text = text[:first_lowercase-1]
    
    #print("header_text1: ", header_text)
    # When I print out pageObj.extractText(), it's missing the "ETHNIC: " part of the 
    # "ETHNIC: HISPANIC OR LATINO ORIGIN (ETHNICITY)" header, so it isn't registering.
    # this is a hack to catch it.
    if header_text.startswith("HISPANIC"):
        header_text = "ETHNIC: HISPANIC OR LATINO ORIGIN (ETHNICITY)"
    #print("header_text2: ", header_text)

    if ':' not in header_text or len(header_text) > 200:
        return None
    header_text = header_text.replace('\n', '')
    print("header_text: ", header_text)


    text = text.replace('\n \n', '\n')
    start = re.search(table_start, text)
    if not start: # has variable name and meaning but not values
        return header_text.split(':'), None
    start = start.end()
    end = re.search(table_end, text)
    if not end: # table continues on next page; go to end of this page
        end = len(text)
    else:
        end = end.start()
    entries = text[start:end]
    entries = entries.replace('\n•\n', '-')
    entries = entries.replace('\n-\n9', '\n-9') # fix the - and 9 being on separate lines problem
    entries = entries.replace('\n-\n', '\n')
    entries = entries.strip()
    entries = entries.split('\n')

    n_entries = len(entries)
    if n_entries < 3:
        return header_text.split(':'), None
    if True:  # damage control
                
        # step through checking if the [3] item has a %
        # if not, verify [4] has a % and then merge [1-2]
        r = 0
        while r + 4 <= len(entries):
            if '%' not in entries[r+3]:
                if not isnumeric(entries[r+2].replace(',', '')):
                    # not isnumeric(entries[r+1].replace(',', '')) and
                    # ['3 ', 'ASIAN OR P', 'ACIFIC ISLANDER', '741', '0.1%']
                    entries[r+1] = entries[r+1] + entries[r+2]
                    entries.pop(r+2)
                elif isnumeric(entries[r+3].replace('.', '')):
                    # ['1 ', 'MALE', '951,949', '6', '5.3%']
                    entries[r+4] = entries[r+3] + entries[r+4]
                    entries.pop(r+3)
                elif isnumeric(entries[r+1]) and isnumeric(entries[r+2]) and int(entries[r+1]) < int(entries[r+2]):
                    # ['4 ', '13', '15', '271,925', '18.6%']
                    entries[r+1] =  entries[r+1] + '-' + entries[r+2]
                    entries.pop(r+2)
                                                        
                elif isnumeric(entries[r+1].replace('-', '')) and isnumeric(entries[r+2]):
                    # ['2 ', '9-', '11', '316,620', '21.7%']
                    entries[r+1] =  entries[r+1] + entries[r+2]
                    entries.pop(r+2)
                elif isnumeric(entries[r+3].replace(',', '')) and isnumeric(entries[r+2]):
                    # ['21', '21', '1', '7,101', '1.2%']
                    # ['7 ', 'OTHER OPIATES AND SYNTHETICS', '1', '11,313', '7.6%']
                    entries[r+3] = entries[r+2] + entries[r+3]
                    entries.pop(r+2)

            if '%' in entries[r+3]:
                r += 4
                
    #print("entries: ", entries)

    n_entries = len(entries)
    n_rows = n_entries / 4
    entries_grid = np.reshape(entries, (int(n_rows), 4))
    #print("entries_grid: ", entries_grid)
    df = pd.DataFrame(entries_grid,
                  columns=['Value', 'Label', 'Frequency', 'Percent'])
    return header_text.split(':'), df


folder_path = "/Users/jgeis/Work/DOH/TEDS-Processing/TEDS-D/codebooks/"
read_pdf(f"{folder_path}TEDS-D-2016-DS0001-info-codebook.pdf")
read_pdf(f"{folder_path}TEDS-D-2015-DS0001-info-codebook.pdf")
