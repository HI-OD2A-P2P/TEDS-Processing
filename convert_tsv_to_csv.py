
"""
This script converts TSV (Tab-Separated Values) files to CSV (Comma-Separated Values) files.
It reads a TSV file, processes its content, and writes it to a new CSV file with the same name,
but with a `.csv` extension.

Usage:
    Call the `tsv_to_csv` function with the path to the TSV file as an argument.
    Example:
        tsv_to_csv("path/to/file.tsv")

    Alternatively, uncomment the `if __name__ == "__main__"` block to enable command-line usage.
"""
import csv
import sys
import os

def tsv_to_csv(tsv_file_path):
    """
    Converts a TSV file to a CSV file.

    Args:
        tsv_file_path (str): The path to the input TSV file.

    Returns:
        None. Writes the converted CSV file to the same directory as the input TSV file.

    Raises:
        FileNotFoundError: If the specified TSV file does not exist.
        Exception: For any other errors that occur during the conversion process.
    """

    try:
        csv_file_path = os.path.splitext(tsv_file_path)[0] + ".csv"

        with open(tsv_file_path, 'r', newline='', encoding='utf-8') as tsvfile, \
             open(csv_file_path, 'w', newline='', encoding='utf-8') as csvfile:

            tsv_reader = csv.reader(tsvfile, delimiter='\t')
            csv_writer = csv.writer(csvfile)

            for row in tsv_reader:
                csv_writer.writerow(row)

        print(f"Successfully converted '{tsv_file_path}' to '{csv_file_path}'")

    except FileNotFoundError:
        print(f"Error: File '{tsv_file_path}' not found.")
    except Exception as e:
        print(f"An error occurred: {e}")

""" 
if __name__ == "__main__":
    if len(sys.argv) != 3:
         print("Usage: python tsv_to_csv.py <input.tsv> <output.csv>")
         sys.exit(1)

    input_tsv = sys.argv[1]
    tsv_to_csv(input_tsv) 
"""

tsv_to_csv("/Users/jgeis/Work/DOH/TEDS-Processing/TEDS-D/csv_files/TEDS-D-2006-DS0001-data-excel.tsv")
tsv_to_csv("/Users/jgeis/Work/DOH/TEDS-Processing/TEDS-D/csv_files/TEDS-D-2007-DS0001-data-excel.tsv")
tsv_to_csv("/Users/jgeis/Work/DOH/TEDS-Processing/TEDS-D/csv_files/TEDS-D-2008-DS0001-data-excel.tsv")
tsv_to_csv("/Users/jgeis/Work/DOH/TEDS-Processing/TEDS-D/csv_files/TEDS-D-2009-DS0001-data-excel.tsv")
tsv_to_csv("/Users/jgeis/Work/DOH/TEDS-Processing/TEDS-D/csv_files/TEDS-D-2010-DS0001-data-excel.tsv")
tsv_to_csv("/Users/jgeis/Work/DOH/TEDS-Processing/TEDS-D/csv_files/TEDS-D-2011-DS0001-data-excel.tsv")

