#!bin/bash

# append all csv file in current directory to main.csv

OUTFILE_NAME="main.csv"

for f in *.csv;
do
    echo $f
    cat $f >> $OUTFILE_NAME
done