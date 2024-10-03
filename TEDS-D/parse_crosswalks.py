# To run, type the following in a terminal window (isn't working from inside VSCode)
# python parse_crosswalks.py 
# pdf_path = '/Users/jgeis/Work/DOH/TEDS-Processing/TEDS-D/codebooks/TEDS-D-2006-2014-DS0001-info-codebook.pdf'

import os
import pdfplumber
import re
import pandas as pd
from itertools import groupby


folder_path = "/Users/jgeis/Work/DOH/TEDS-Processing/TEDS-D/codebooks/"
        #col_types = {,"DAYWAIT":"string","SERVICES_D":"string","REASON":"string","EMPLOY_D":"string","LIVARAG_D":"string","ARRESTS_D":"string","DSMCRIT":"string","AGE":"string","RACE":"string","ETHNIC":"string","DETNLF":"string","DETNLF_D":"string","PRIMINC":"string","SUB1":"string","SUB2":"string","SUB3":"string","SUB1_D":"string","SUB2_D":"string","SUB3_D":"string","ROUTE1":"string","ROUTE2":"string","ROUTE3":"string","FREQ1":"string","FREQ2":"string","FREQ3":"string","FREQ1_D":"string","FREQ2_D":"string","FREQ3_D":"string","FRSTUSE1":"string","FRSTUSE2":"string","FRSTUSE3":"string","HLTHINS":"string","PRIMPAY":"string","FREQ_ATND_SELF_HELP":"string","FREQ_ATND_SELF_HELP_D":"string","ALCFLG":"string","COKEFLG":"string","MARFLG":"string","HERFLG":"string","METHFLG":"string","OPSYNFLG":"string","PCPFLG":"string","HALLFLG":"string","MTHAMFLG":"string","AMPHFLG":"string","STIMFLG":"string","BENZFLG":"string","TRNQFLG":"string","BARBFLG":"string","SEDHPFLG":"string","INHFLG":"string","OTCFLG":"string","OTHERFLG":"string","DIVISION":"string","REGION":"string","IDU":"string","ALCDRUG":"string","CBSA":"string","PMSA":"string","SERVSETD":"string","NUMSUBS":"string","YEAR":"string"}

# List of section headers to include
target_headers = [
    "CBSA",
    "CBSA",
    "DISYR",
    "AGE",
    "GENDER",
    "RACE",
    "ETHNIC",
    "MARSTAT",
    "EDUC",
    "EMPLOY",
    "EMPLOY_D",
    "DETNLF",
    "DETNLF_D",
    "PREG",
    "VET",
    "LIVARAG",
    "LIVARAG_D",
    "PRIMINC",
    "ARRESTS",
    "ARRESTS_D",
    "STFIPS",
    "CBSA2020",
    "REGION",
    "DIVISION",
    "SERVICES",
    "SERVICES_D",
    "SERVSETD",
    "METHUSE",
    "DAYWAIT",
    "DAYWAIT",
    "REASON",
    "LOS",
    "LOS",
    "PSOURCE",
    "PSOURCE",
    "DETCRIM",
    "DETCRIM",
    "NOPRIOR",
    "NOPRIOR",
    "SUB1",
    "SUB1_D",
    "ROUTE1",
    "FREQ1",
    "FREQ1_D",
    "FRSTUSE1",
    "SUB2",
    "SUB2_D",
    "ROUTE2",
    "FREQ2",
    "FREQ2_D",
    "FRSTUSE2",
    "SUB3",
    "SUB3_D",
    "ROUTE3",
    "FREQ3",
    "FREQ3_D",
    "FRSTUSE3",
    "IDU"
    "ALCFLG",
    "COKEFLG",
    "MARFLG",
    "HERFLG",
    "METHFLG",
    "OPSYNFLG",
    "PCPFLG",
    "HALLFLG",
    "MTHAMFLG",
    "AMPHFLG",
    "STIMFLG",
    "BENZFLG",
    "TRNQFLG",
    "BARBFLG",
    "SEDHPFLG",
    "INHFLG",
    "OTCFLG",
    "OTHERFLG",
    "ALCDRUG",
    "DSMCRIT",
    "PSYPROB",
    "HLTHINS",
    "PRIMPAY",
    "FREQ_ATND_SELF_HELP",
    "FREQ_ATND_SELF_HELP_D",
    "NUMSUBS"
]

# Function to remove consecutive duplicate characters
#def remove_duplicate_characters(text):
#    #return ''.join(c * min(2, len(list(g))) for c, g in groupby(text))
#    return ''.join(c for i, c in enumerate(text) if i == 0 or c != text[i-1])

def remove_duplicate_characters(s):
    result = []
    i = 0
    while i < len(s):
        # Check if the current character is the same as the next character
        if i + 1 < len(s) and s[i] == s[i + 1]:
            # If they are the same, append one to the result and skip the next character
            result.append(s[i])
            i += 2
        else:
            # If they are not the same, just append the current character
            result.append(s[i])
            i += 1
    return ''.join(result)

def get_text_before_colon(s):
    match = re.match(r'^(.*?):', s)
    if match:
        return match.group(1)
    return None

# Function to extract headers and tables from the PDF
def extract_sections_and_values(pdf_path):
    sections = {}
    current_section = None

    # Open the PDF with pdfplumber
    with pdfplumber.open(pdf_path) as pdf:
        for page in pdf.pages:
            text = page.extract_text()
            lines = text.split("\n")
            if (len(lines) == 2 and lines[0] == "APPENDICES"):
                print("reached appendices")
                return sections
            for line in lines:
                #line = line.strip()
                
                # Deduplicate only for header lines, it's an artifact of the bolded header that messes up pdfplumber
                cleaned_line = remove_duplicate_characters(line.strip())
                
                # Detect section headers (assuming they are uppercase and in target headers)
                print(f"   line: {line}, cleaned_line: {cleaned_line}, in headers: {cleaned_line.upper() in target_headers}")
                # make sure cleaned_line doesn't equal current_section because if it does, we've moved to a new page
                # and the new page's data will overwrite the existing data.
                #print("in headers: ", cleaned_line in target_headers)
                #if cleaned_line != current_section and cleaned_line.upper() in target_headers:
                result = get_text_before_colon(cleaned_line)

                if result and result != current_section and result.upper() in target_headers:
                    current_section = result
                    print("current_section: ", current_section, "\n")
                    sections[current_section] = []
                # Detect table entries for value and label (ignoring unwanted columns)
                elif current_section:
                    # Look for lines that have 'value' and 'label' structure, ignoring other columns
                    match = re.match(r"(-?\d+)\s+(.+?)(?=\s+\d|\s+%)", line)
                    if match:
                        value = match.group(1)
                        label = match.group(2)
                        print("    match: ", value, ", ", label, "\n")
                        sections[current_section].append({'value': value, 'label': label})

    return sections

# Save the extracted sections and tables to a CSV
def save_to_csv(sections, output_csv):
    all_data = []
    
    for section, rows in sections.items():
        for row in rows:
            row['section'] = section
            all_data.append(row)
    
    df = pd.DataFrame(all_data)
    df.to_csv(output_csv, index=False)

# Function to process a single PDF
def process_pdf(pdf_path):
  """
  Extracts data from a PDF and saves it to a CSV file.

  Args:
      pdf_path: The path to the PDF file.
  """
  filename = os.path.splitext(os.path.basename(pdf_path))[0]  # Extract filename without extension
  output_csv = f"{folder_path}{filename}.csv"  # Create CSV filename with same name
  sections = extract_sections_and_values(pdf_path)
  save_to_csv(sections, output_csv)
  print(f"Processed {pdf_path} and saved results to {output_csv}")

"""
Processes all PDFs in a directory and saves results to individual CSV files.
"""
"""
# Main execution
def main():
  directory = "/Users/jgeis/Work/DOH/TEDS-Processing/TEDS-D/codebooks"  # Replace with the actual directory path
  for filename in os.listdir(directory):
    if filename.endswith(".pdf"):
      pdf_path = os.path.join(directory, filename)
      process_pdf(pdf_path)

if __name__ == "__main__":
  main()
  print("All PDFs processed!")
"""



# Main execution
pdf_path = f"{folder_path}TEDS-D-2006-2014-DS0001-info-codebook.pdf"
process_pdf(pdf_path)

""" output_csv = 'extracted_codebook_filtered.csv'

sections = extract_sections_and_values(pdf_path)
save_to_csv(sections, output_csv)

print(f"Data extracted and saved to {output_csv}") """


# 2006:TRNQFLG and PSYPROB missing
