import sys

def remove_trailing_comma(in_file_name, out_file_name):
    in_file = open(in_file_name, 'r')
    out_file = open(out_file_name, 'w')

    for line in in_file.readlines():
        if line.endswith(",\n"):
            line = line[0:-2] + '\n'
        elif line.endswith(","):
            line = line[0:-1]
            
        out_file.write(line)

    in_file.close()
    out_file.close()

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("<input file> <output file> as command line argument")
        exit(0)

    remove_trailing_comma(sys.argv[1], sys.argv[2])