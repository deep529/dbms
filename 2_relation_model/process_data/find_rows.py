import sys
import csv

YEAR = "2017"
MONTH = "11"
DAY = "16"
FLIGHT_NUMBER = "4529"
AIRLINE_CARRIER_CODE = "OO"
AIRCRAFT_TAIL_NUM = "N604SK"
ORIGIN_AIRPORT_ID = "13487"
CRS_DEPT_TIME = "1945"

YEAR_INDEX = 0
MONTH_INDEX = 1
DAY_INDEX = 2
FLIGHT_NUMBER_INDEX = 5
AIRLINE_CARRIER_CODE_INDEX = 3
AIRCRAFT_TAIL_NUM_INDEX = 4
ORIGIN_AIRPORT_ID_INDEX = 6
CRS_DEPT_TIME_INDEX = 8

def find_rows(in_file_name):
    in_file = open(in_file_name, 'r')
    in_file_reader = csv.reader(in_file)

    print("ok")
    count = 0
    for row in in_file_reader:
        if row[YEAR_INDEX] == YEAR and row[MONTH_INDEX] == MONTH and row[DAY_INDEX] == DAY and row[FLIGHT_NUMBER_INDEX] == FLIGHT_NUMBER and row[AIRLINE_CARRIER_CODE_INDEX] == AIRLINE_CARRIER_CODE and row[AIRCRAFT_TAIL_NUM_INDEX] == AIRCRAFT_TAIL_NUM and row[ORIGIN_AIRPORT_ID_INDEX] == ORIGIN_AIRPORT_ID and row[CRS_DEPT_TIME_INDEX] == CRS_DEPT_TIME:
            print(row, end="\n\n")
    print("wow")

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("<Original file> as command line argument")
        exit(0)

    find_rows(sys.argv[1])
