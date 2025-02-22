# reads in pdf files specified at the bottom of the file and extracts the 
# code, value, and label columns and writes it out to a csv file.

from PyPDF4 import PdfFileReader, PdfFileWriter
import numpy as np
import re
import pandas as pd

# /opt/anaconda3/bin/python3 /Users/jgeis/Work/DOH/TEDS-Processing/TEDS-D/read_tedsa_and_tedsd_2017_19.py

# does not work for 2020

# code gotten from https://github.com/kabellhart/teds-processing/blob/main/README.md 

# helpful for debugging:
# PyPDF4.PdfFileReader(open('fname', 'rb')).getPage(n).extractText()

# define regex patterns to look for above and below tables
header = re.compile(r'[A-Z0-9_]+: [A-Z].*\n([a-z0-9].*)*')

table_start = re.compile(r'\nValue\nLabel\nFrequency\n%\n')
table_end = re.compile('\n \nTotal')

# read in a PDF
def read_pdf(filename):
    global pdfFileObj, pdfReader, npages
    pdfFileObj = open(filename, 'rb')
    pdfReader = PdfFileReader(pdfFileObj)
    npages = pdfReader.numPages
    dfs = []
    for page in range(npages):
        result = read_page(page)
        if result:
            (code, label), df = result
            code = code.strip().replace('\n', ' ')
            label = label.strip().replace('\n', ' ')
            if df is not None:
                df['code'] = code
                df['full_label'] = label
                dfs.append(df)
            else:
                dfs.append(pd.DataFrame.from_dict({'code': [code], 'full_label': [label]}))

    pd.concat(dfs).to_csv(filename[:-4] + '_codes.csv')


def read_page(page_num):
    pageObj = pdfReader.getPage(page_num)
    text = pageObj.extractText()
    print("PAGE: ", page_num)
    print(text)
    header_results = re.search(header, text)
    print("header_results: ", header_results)
    if not header_results: # not a data page
        return None
    
    header_text = re.search(header, text).group(0)
    print("header_text: ", header_text)

    start = re.search(table_start, text)
    if not start: # has variable name and meaning but not values
        return header_text.split(': '), None
    start = start.end()
    end = re.search(table_end, text)
    if not end: # table continues on next page; go to end of this page
        end = len(text)
    else:
        end = end.start()
    entries = text[start:end]
    entries = entries.replace('\n•\n', '-')
    entries = entries.strip()
    entries = entries.split('\n')
    n_entries = len(entries)
    
    if n_entries % 4:  # damage control
                
        # step through checking if the [3] item has a %
        # if not, verify [4] has a % and then merge [1-2]
        r = 3
        while r + 1 <= len(entries):
            if '%' not in entries[r] and '%' in entries[r+1]:
                entries[r-2] = entries[r-2] + entries[r-1]
                entries.pop(r-1)
            else:
                assert '%' in entries[3]
            r += 4
                

    n_rows = n_entries / 4
    entries_grid = np.reshape(entries, (int(n_rows), 4))
    df = pd.DataFrame(entries_grid,
                  columns=['Value', 'Label', 'Frequency', 'Percent'])
    return header_text.split(': '), df

folder_path = "/Users/jgeis/Work/DOH/TEDS-Processing/TEDS-D/codebooks/"
read_pdf(f"{folder_path}TEDS-D-2019-DS0001-info-codebook_V1.pdf")
read_pdf(f"{folder_path}TEDS-D-2018-DS0001-info-codebook.pdf")
read_pdf(f"{folder_path}TEDS-D-2017-DS0001-info-codebook.pdf")
