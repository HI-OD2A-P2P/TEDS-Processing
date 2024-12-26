# reads in pdf files specified at the bottom of the file and extracts the 
# code, value, and label columns and writes it out to a csv file.
#
# Processes SAMHSA 2020 codebook PDF document and extracts structured tabular data into a CSV file
# Key Logic Details
# Handling Multiline Entries:
#  If the table rows aren't properly aligned (e.g., some rows span multiple lines), the script attempts to merge misaligned entries.
# Reshaping Data:
#  The script reshapes the flattened list of table entries (entries) into a grid format using np.reshape.
# Output Format:
#  Each page's data is appended into a DataFrame with additional columns:
#   code: Extracted from the header (e.g., VAR_CODE).
#   full_label: The complete description text from the header.

#from PyPDF4 import PdfFileReader, PdfFileWriter
import numpy as np
import re
import pandas as pd
import fitz  # PyMuPDF


# /opt/anaconda3/bin/python3 /Users/jgeis/Work/DOH/TEDS-Processing/TEDS-D/read_tedsd_2020_2022.py

# adapted from code gotten from https://github.com/kabellhart/teds-processing/blob/main/README.md 

# helpful for debugging:
# PdfFileReader(open('fname', 'rb')).getPage(n).extractText()

# TODO: missing 'Age: age at admission' for 2021 and 2022, works for 2020


# define regex patterns to look for above and below tables
header = re.compile(r'[A-Z0-9_]+: [A-Z].*\n([a-z0-9].*)*')
table_start = re.compile(r'\nValue\nLabel\nFrequency\n%\n')
#table_end = re.compile('\n \nTotal')
# sometimes there's not an extra newline before the 'total' row, this messes up the parsing.  Had to change to look for "Total  num  100%" pattern. 
table_end = re.compile(r"Total\s+(\d{1,3}(?:,\d{3})*)\s+100%") 

# Purpose: 
#  Reads the PDF file, processes its pages, and extracts tabular data.
# Steps:
#  Opens the PDF file and initializes the PdfFileReader.
#  Iterates over all pages of the PDF.
#  Calls read_page(page) to process each page and extract data.
#  Cleans and formats the code and label from the header.
#  Appends the data into a list of pandas DataFrames.
#  Concatenates all DataFrames and saves them as a CSV file.
def read_pdf(filename):
    global pdfFileObj, pdfReader, npages
    pdfFileObj = open(filename, 'rb')

    #pdfReader = PdfFileReader(pdfFileObj)
    
    pdf_document = fitz.open(filename)
    page = pdf_document[12]
    text = page.get_text()  # Extract text from page
    #print("text1: ", text)

    #npages = pdfReader.numPages
    npages = len(pdf_document)
    dfs = []
    # skip to the page after CASEID (use 12)
    for page in range(npages):
        result = read_page(pdf_document, page)
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

def is_page_number(text):
    # Common page number patterns
    page_number_patterns = [
        r'^\d+$',            # Matches a single number (e.g., "12")
        r'^Page\s*\d+$',     # Matches "Page 12"
        r'^\d+\s*/\s*\d+$'   # Matches "12/50"
    ]
    for pattern in page_number_patterns:
        if re.match(pattern, text.strip()):
            return True
    return False

def is_near_bottom(y_position, page_height, margin=50):
    return y_position > (page_height - margin)

def detect_page_number(text, y_position, page_height):
    if is_page_number(text) and is_near_bottom(y_position, page_height):
        return True
    return False

def detect_page_number_for_page(page, page_num):
    blocks = page.get_text("blocks")  # Extract text blocks
    page_height = page.rect.height
    
    for block in blocks:
        x0, y0, x1, y1, text, _, _ = block  # Unpack block properties
        if is_page_number(text) and is_near_bottom(y1, page_height):
            # for unknown reasons, the page number we use to get a specific page is 
            # actually 2 pages ahead of the number on the bottom of the page.
            #print(f"Page {page_num}: Detected page number: {text}")
            return text

# Purpose: Extracts text, headers, and tables from a single page of the PDF.
# Steps:
# Text Extraction:
#  Reads text from the given page.
# Header Detection:
#  Uses regex (header) to locate the header section.
#  If no header is found, the page is skipped.
# Table Detection:
#  Looks for the table start (table_start) and end (table_end) markers.
#  If only a header is present without a table, it processes the header separately.
# Entry Parsing:
#  Extracts the table data between the start and end markers.
#  Fixes formatting issues (e.g., handling multiline entries).
#  Reshapes the entries into rows and columns using numpy and creates a pandas DataFrame.
# Return Values: 
#   Returns the header and the DataFrame for the table.
def read_page(pdf_document, page_num):
    page = pdf_document[page_num]
    text = page.get_text()  # Extract text from page

    #detected_page_num = detect_page_number_for_page(page, page_num) 
    #print("detected_page_num: ", detected_page_num)

    print("PAGE: ", page_num)
    print("text: ", text)
    print("EOT")

    header_results = re.search(header, text)

    print("header_results: ", header_results)
    if not header_results: # not a data page
        return None
    
    header_text = re.search(header, text).group(0)
    print("header_text: ", header_text)

    start = re.search(table_start, text)
    print("start: ", start)
    if not start: # has variable name and meaning but not values
        #print("not start: ", header_text.split(': '))
        return header_text.split(': '), None
    start = start.end()
    print("start.end: ", start)
    end = re.search(table_end, text)
    if not end: # table continues on next page; go to end of this page
        end = len(text)
        print("not end: ", len(text))
    else:
        end = end.start()
        print("end: ", end)
    entries = text[start:end]
    print("entries: ", entries)
    entries = entries.replace('\n•\n', '-')
    entries = entries.strip()
    entries = entries.split('\n')
    print("mod1: ", len(entries) % 4)

    if len(entries) % 4:  # damage control
                
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

    #print("mod2: ", len(entries) % 4)
    # sometimes the page number gets appended to the entries array.  If so, get it out of there
    if len(entries) % 4:
        last_element = int(entries[-1])
        detected_page_num = int(detect_page_number_for_page(page, page_num))
        #print("last_element: ", last_element, ", detected_page_num: ", detected_page_num, ", result: ", last_element == detected_page_num, ", type1: ", type(last_element), ", type2: ", type(detected_page_num))
        if (last_element == detected_page_num):
             #print("popping")
             entries.pop()

    n_rows = len(entries) / 4

    print("Entries:", entries)
    print("Number of entries:", len(entries))
    print("len(entries):", len(entries), "n_rows:", n_rows)

    entries_grid = np.reshape(entries, (int(n_rows), 4))
    df = pd.DataFrame(entries_grid,
                  columns=['Value', 'Label', 'Frequency', 'Percent'])
    return header_text.split(': '), df

folder_path = "/Users/jgeis/Work/DOH/TEDS-Processing/TEDS-D/codebooks/"
read_pdf(f"{folder_path}TEDS-D-2020-DS0001-info-codebook.pdf")
read_pdf(f"{folder_path}TEDS-D-2021-DS0001-info-codebook.pdf")
read_pdf(f"{folder_path}TEDS-D-2022-DS0001-info-codebook_v1.pdf")