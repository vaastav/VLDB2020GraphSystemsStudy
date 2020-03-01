import os
import sys
import re

def parse_rmat_file(infile, outfile):
    num_vertices = -1
    num_edges = -1
    edges = []
    with open(infile, 'r') as fin:
        for line in fin:
            edge = re.findall(r"(\d+)", line)
            if len(edge) != 2:
                print(line)
            edges += [edge]
    with open(outfile, 'w') as fout:
        for edge in edges:
            fout.write(edge[0] + " " + edge[1] + "\n")

def main():
    if len(sys.argv) != 3:
        print("Usage: python convert_snap_rmat.py <input_file> <output_file>")
        sys.exit(1)
    parse_rmat_file(sys.argv[1], sys.argv[2])

if __name__ == '__main__':
    main()
