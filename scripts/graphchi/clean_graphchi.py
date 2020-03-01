import os
import sys

def clean_file(filename):
    lines = []
    with open(filename, 'r') as inf:
        count = 0
        prev_line = ''
        for line in inf:
            count += 1
            if count % 2 == 0:
                curr_line = prev_line.strip() + ',' + line
                lines += [curr_line]
            else:
                prev_line = line
    line = "Algorithm,Dataset,Iteration,Real,User,Sys\n"
    lines = [line] + lines
    with open(filename, 'w+') as outf:
        for line in lines:
            outf.write(line)

def main():
    if len(sys.argv) != 2:
        print("Usage: python clean_graphchi.py <dir_name>")
        sys.exit(1)
    dir = sys.argv[1]
    for subdir,dirs,files in os.walk(dir):
        for file in files:
            filepath = os.path.join(subdir, file)
            if filepath.endswith(".csv"):
                clean_file(filepath)

if __name__ == '__main__':
    main()
