import os
import sys

def parse_rmat_file(infile, outfile):
    num_vertices = -1
    num_edges = -1
    vertex_offsets = []
    list_of_edges = []
    with open(infile, 'r') as fin:
        line_num = 0
        current_vertices = 0
        for line in fin:
            if line_num == 0:
                print("Parsing", line.strip())
            elif line_num == 1:
                num_vertices = int(line.strip())
            elif line_num == 2:
                num_edges = int(line.strip())
            elif line_num >= 3 and current_vertices < num_vertices:
                vertex_offsets += [int(line.strip())]
                current_vertices += 1
            else:
                list_of_edges += [int(line.strip())]
            line_num += 1
    print("Num Vertices", num_vertices, len(vertex_offsets))
    print("Num Edges", num_edges, len(list_of_edges))
    vertex_edge_list = {}
    for i in range(len(vertex_offsets)):
        if i == num_vertices - 1:
            vertex_edge_list[i] = list_of_edges[vertex_offsets[i]:]
        else:
            vertex_edge_list[i] = list_of_edges[vertex_offsets[i]:vertex_offsets[i+1]]
    print("Writing output file")
    with open(outfile, 'w') as fout:
        for vertex in sorted(vertex_edge_list):
            for dst in vertex_edge_list[vertex]:
                fout.write(str(vertex) + " " + str(dst) + "\n")

def main():
    if len(sys.argv) != 3:
        print("Usage: python convert_ligra_rmat.py <input_file> <output_file>")
        sys.exit(1)
    parse_rmat_file(sys.argv[1], sys.argv[2])

if __name__ == '__main__':
    main()
