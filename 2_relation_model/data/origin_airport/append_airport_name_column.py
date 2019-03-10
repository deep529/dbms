import sys
import csv

INSERT_AT_COLUMN = 4
KEY_COLUMN = 3

def get_dict(mapping_file_name):
    mapping_file = open(mapping_file_name, "r")
    mapping_file_reader = csv.reader(mapping_file)

    airport_name = {}
    count = 0
    for row in mapping_file_reader:
        if row[0] in airport_name.keys():
            print("Found multiple keys: {}".format(row[0]))
            exit(0)

        airport_name[row[0]] = row[1]
        count += 1
    
    print("Found {} unique mappings".format(count))
    return airport_name


def append_column(in_file_name, mapping_file_name, out_file_name):
    airport_name = get_dict(mapping_file_name)
    
    in_file = open(in_file_name, 'r')
    in_file_reader = csv.reader(in_file)

    out_file = open(out_file_name, 'w', newline='')
    out_file_writer = csv.writer(out_file, delimiter=',')

    # write header
    header = next(in_file_reader)
    header = header[0:INSERT_AT_COLUMN] + ["AIRPORT_NAME"] + header[INSERT_AT_COLUMN:]
    out_file_writer.writerow(header)

    count = 1
    for row in in_file_reader:
        row = row[0:INSERT_AT_COLUMN] + [airport_name[row[KEY_COLUMN]]] + row[INSERT_AT_COLUMN:]
        out_file_writer.writerow(row)
        count += 1

    print("Updated {} rows successfully".format(count))


if __name__ == "__main__":
    if len(sys.argv) != 4:
        print("<Original file> <Mapping file> <Output file> as command line argument")
        exit(0)
    append_column(sys.argv[1], sys.argv[2], sys.argv[3])
