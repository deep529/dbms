""" Removes all duplicate lines """
import sys

def remove_dup_lines(in_file_name, out_file_name):
    in_file = open(in_file_name, 'r')
    out_file = open(out_file_name, 'w')

    prev_lines = set()
    count = 0
    duplicates = 0

    for line in in_file.readlines():
        if line in prev_lines:
            duplicates += 1
        else:
            out_file.write(line)
            prev_lines.add(line)
            count += 1

    print("{} rows written".format(count))
    print("{} duplicates found".format(duplicates))
    in_file.close()
    out_file.close()


if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("<input file> <output file> as command line argument")
        exit(0)
    
    remove_dup_lines(sys.argv[1], sys.argv[2])
