import pandas as pd
import numpy as np
import sys
import os

def convert(tsv_file, outfile):
    csv_table = pd.read_table(tsv_file, sep='\t')
    csv_table.to_csv(outfile,index=False)

def main():
    if len(sys.argv) != 2:
        print("Usage: python tsv2csv.py <tsv_file>")
        sys.exit(1)

    filename = sys.argv[1]
    dirname = os.path.dirname(filename)
    basename = os.path.basename(filename)
    outfile = os.path.join(dirname, basename.split('.')[0] + ".csv")
    convert(filename, outfile)

if __name__ == '__main__':
    main()
