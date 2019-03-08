import sys

if len(sys.argv) != 3:
    print("<input file> <output file> as command line argument")
    exit(0)


in_file = open(sys.argv[1], 'r')
out_file = open(sys.argv[2], 'w')

for line in in_file.readlines():
    if line.endswith(",\n"):
        line = line[0:-2] + '\n'
    elif line.endswith(","):
        line = line[0:-1]
        
    out_file.write(line)