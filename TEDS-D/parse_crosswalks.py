# To run, type the following in a terminal window (isn't working from inside VSCode)
# python parse_crosswalks.py 
# pdf_path = '/Users/jgeis/Work/DOH/TEDS-Processing/TEDS-D/codebooks/TEDS-D-2006-2014-DS0001-info-codebook.pdf'

import os
import pdfplumber
import re
import pandas as pd
#from itertools import groupby

folder_path = "/Users/jgeis/Work/DOH/TEDS-Processing/TEDS-D/codebooks/"

# List of section headers to include
target_headers = [
    "CBSA",
    "CBSA2010",
    "CBSA2020",
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
    "REGION",
    "DIVISION",
    "SERVICES",
    "SERVICES_D",
    "SERVSETD",
    "METHUSE",
    "DAYWAIT",
    "REASON",
    "LOS",
    "PSOURCE",
    "DETCRIM",
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
    "NUMSUBS",
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
    "FREQ_ATND_SELF_HELP_D"
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
    filename = os.path.splitext(os.path.basename(pdf_path))[0]  # Extract filename without extension
    sections = {}
    current_section = None

    # Open the PDF with pdfplumber
    with pdfplumber.open(pdf_path) as pdf:
        for page in pdf.pages:
            text = page.extract_text()
            lines = text.split("\n")
            # kick out at appendices as we don't want that to be processed.
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
                        label = match.group(2).capitalize()
                        print("    match: ", value, ", ", label, "\n")
                        sections[current_section].append({'value': value, filename: label})

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

# Main execution
"""
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

""" def merge_csv_files(directory):
    # Get list of CSV files in the directory
    csv_files = [f for f in os.listdir(directory) if f.endswith('.csv')]
    
    # Initialize an empty list to hold dataframes for merging
    data_frames = []

    for file in csv_files:
        # Read each CSV file into a dataframe
        df = pd.read_csv(os.path.join(directory, file), header=None, names=["value", "label", "section"])
        
        # Reformat dataframe: group by section and value
        df = df.groupby(["section", "value"])["label"].apply(list).reset_index()
        
        # Create a new column name from the file name (without .csv extension)
        file_column_name = file.replace('.csv', '_label')  # Adding '_label' to clarify purpose
        
        # Convert the labels to strings and join them into a single string
        df[file_column_name] = df['label'].apply(lambda x: ', '.join(str(item) for item in x if pd.notnull(item)))
        print(df)
        # Drop the original label column
        df.drop(columns=['label'], inplace=True)

        # Append dataframe to the list
        data_frames.append(df)
    
    # Merge all dataframes on section and value
    merged_df = data_frames[0]
    for df in data_frames[1:]:
        merged_df = pd.merge(merged_df, df, on=["section", "value"], how="outer")
        
    # Save the merged dataframe to a new CSV file
    merged_df.to_csv(os.path.join(directory, 'merged_output.csv'), index=False) """
"""
def merge_csv_files(directory):
    # Initialize a list to hold dataframes
    dataframes = []

    # Loop through each CSV file in the directory
    for filename in os.listdir(directory):
        print(filename)
        if filename.endswith('.csv'):
            # Read the CSV file
            file_path = os.path.join(directory, filename)
            df = pd.read_csv(file_path)
            print(df)

            # Ensure that 'value' and 'section' are treated as strings to avoid type issues
            df['value'] = df['value'].astype(str)
            df['section'] = df['section'].astype(str)

            # Add the unique column name to the dataframe (assumes the unique column is the first one in the CSV)
            unique_column_name = df.columns[2]  # Adjust index if needed for unique column
            print(unique_column_name)
            dataframes.append(df)

    # Merge all dataframes together using concat, keeping all columns
    merged_output = pd.concat(dataframes, axis=0, ignore_index=True)

    # Save the merged dataframe to a new CSV
    merged_output.to_csv(f'{folder_path}merged_output.csv', index=False)
"""

def merge_csv_files(directory):
    # Get list of CSV files in the directory
    csv_files = [f for f in os.listdir(directory) if f.endswith('.csv')]
    
    # Initialize an empty list to hold dataframes for merging
    data_frames = []

    for file in csv_files:
        if (file != "merged_output.csv"):
            print(file)
            # Read each CSV file into a dataframe
            # Assuming the unique column is the first one, and using None for header to treat all columns as data
            df = pd.read_csv(os.path.join(directory, file), header=None)
            
            # Assuming the structure is value, section, unique_column_name
            # You can specify the names here according to your file structure
            df.columns = ["value", "unique_label", "section"]
            
            # Reformat dataframe: group by section and value
            # Use the unique label for grouping
            df_grouped = df.groupby(["section", "value"])["unique_label"].apply(list).reset_index()
            
            # Create a new column name from the file name (without .csv extension)
            #file_column_name = file.replace('.csv', '_label')  # Adding '_label' to clarify purpose
            
            # Convert the labels to strings and join them into a single string
            df_grouped[file] = df_grouped['unique_label'].apply(lambda x: ', '.join(str(item) for item in x if pd.notnull(item)))
            
            # Drop the original unique_label column
            df_grouped.drop(columns=['unique_label'], inplace=True)

            # Append dataframe to the list
            data_frames.append(df_grouped)
    
    # Merge all dataframes on section and value
    merged_df = data_frames[0]
    for df in data_frames[1:]:
        merged_df = pd.merge(merged_df, df, on=["section", "value"], how="outer")
        
    # Save the merged dataframe to a new CSV file
    merged_df.to_csv(os.path.join(directory, 'merged_output.csv'), index=False)


# TODO: 
# - make all values output as camel case or lower case with just the first letter capitalized
# - Age is not processing correctly, some have "years old" some don't, also, some just give a single number, not a range

#merge_csv_files(folder_path)


# Main execution
pdf_path = f"{folder_path}TEDS-D-2019-DS0001-info-codebook_V1.pdf"
process_pdf(pdf_path)

""" output_csv = 'extracted_codebook_filtered.csv'

sections = extract_sections_and_values(pdf_path)
save_to_csv(sections, output_csv)

print(f"Data extracted and saved to {output_csv}") """


# 2006:TRNQFLG and PSYPROB missing
