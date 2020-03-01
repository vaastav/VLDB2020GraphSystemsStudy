import os
import sys

def parse_input_file(filename, bfs_nodes_filename):
    lines = []
    lines += ["Real,User,Sys,Load,Exec,Vertices"]
    with open(filename, 'r') as inf:
        is_prev_line_found_vertices=False
        load_time = ""
        exec_time = ""
        found_vertices = ""
        for line in inf:
            line = line.strip()
            if is_prev_line_found_vertices:
                new_line = line + "," + load_time + "," + exec_time + "," + found_vertices
                lines += [new_line]
                is_prev_line_found_vertices = False
            else:
                pieces = line.split("=")
                if pieces[0].strip() == 'load_time':
                    load_time = pieces[1].split('(')[0]
                elif pieces[0].strip() == 'exec_time':
                    exec_time = pieces[1].split('(')[0]
                elif pieces[0].strip() == 'found_vertices':
                    found_vertices = pieces[1].strip()
                    is_prev_line_found_vertices = True

    nodes = ['Node\n']
    with open(bfs_nodes_filename,'r') as inf:
        for line in inf:
            nodes += [line]

    new_lines = []
    for l,n in zip(lines, nodes):
        new_line = l + "," + n
        new_lines += [new_line]

    print(len(new_lines))
    return new_lines

def write_output_file(filename, lines):
    with open(filename, 'w+') as outf:
        for line in lines:
            outf.write(line)

def main():
    if len(sys.argv) != 4:
        print("Usage: python parse_bfs_output.py <input_file> <output_file> <bfs_nodes_file>")
        sys.exit(1)
    input_file = sys.argv[1]
    output_file = sys.argv[2]
    bfs_nodes_file = sys.argv[3]
    lines = parse_input_file(input_file, bfs_nodes_file)
    write_output_file(output_file, lines)

if __name__ == '__main__':
    main()
