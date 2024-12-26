# takes all the previously generaged _codes.csv files in the codebooks 
# directory and merges them into a single csv file.

# /usr/local/bin/python3 /Users/jgeis/Work/DOH/TEDS-Processing/TEDS-D/merge_codebooks.py
import pandas as pd
import os
import glob

# Define the directory containing the CSV files
directory = "/Users/jgeis/Work/DOH/TEDS-Processing/TEDS-D/codebooks/"


# Find all CSV files matching the pattern
file_pattern = os.path.join(directory, "*_codes.csv")
csv_files = glob.glob(file_pattern)

# Initialize the merged DataFrame
merged_df = pd.DataFrame()

for file in csv_files:
    # Read the current CSV file, keeping only necessary columns
    df = pd.read_csv(file, usecols=['code', 'Value', 'Label'], dtype=str)
    
    # Omit rows where 'Label' equals 'Total' or 'Value' is empty
    df = df[(df['Label'] != 'Total') & (df['Value'] != "")] 

    # Omit rows where 'Label' equals 'Total'
    df = df[df['Label'] != 'Total'] 

    # Omit rows where 'Value' is empty
    df = df[df['Value'] != ''] 

    # Make all capitalization the same
    df['Label'] = df['Label'].str.title() 

    # Ensure consistent formatting by stripping whitespace from strings
    df['code'] = df['code'].str.strip()
    df['Value'] = df['Value'].str.strip()
    df['Label'] = df['Label'].str.strip()
    
    # Extract the file name without extension to name the Label column
    file_name = os.path.splitext(os.path.basename(file))[0]
    
    # Rename the Label column to the current file name
    df = df.rename(columns={'Label': file_name})
    # now rename each of those columns to just say the year(s)
    df = df.rename(columns={'TEDS-D-2006-2014-DS0001-info-codebook_codes': '2006_2014'})
    df = df.rename(columns={'TEDS-D-2015-DS0001-info-codebook_codes': '2015'})
    df = df.rename(columns={'TEDS-D-2016-DS0001-info-codebook_codes': '2016'})
    df = df.rename(columns={'TEDS-D-2017-DS0001-info-codebook_codes': '2017'})
    df = df.rename(columns={'TEDS-D-2018-DS0001-info-codebook_codes': '2018'})
    df = df.rename(columns={'TEDS-D-2019-DS0001-info-codebook_V1_codes': '2019'})
    df = df.rename(columns={'TEDS-D-2020-DS0001-info-codebook_codes': '2020'})
    df = df.rename(columns={'TEDS-D-2021-DS0001-info-codebook_codes': '2021'})
    df = df.rename(columns={'TEDS-D-2022-DS0001-info-codebook_v1_codes': '2022'})

    # Rename columns based on file names (simplified)
    #year = file_name.split("-")[1]  # Extract year from filename
    #df = df.rename(columns={file_name: year})

    # Merge with the main DataFrame
    if merged_df.empty:
        merged_df = df
    else:
        merged_df = pd.merge(
            merged_df, df, 
            on=['code', 'Value'], how='outer'
        )

# Sort columns
desired_order = ['code', 'Value', '2006_2014', '2015', '2016', '2017', '2018', '2019', '2020', '2021', '2022']
merged_df = merged_df[desired_order]

# Save the merged DataFrame to a new CSV file
output_file = os.path.join(directory, "merged_codes_result.csv")
merged_df.to_csv(output_file, index=False)

print(f"Merged CSV file saved to: {output_file}")