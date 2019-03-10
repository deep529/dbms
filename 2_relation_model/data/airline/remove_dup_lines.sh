#!bin/bash

OUT_DIR="__output__"
mkdir $OUT_DIR

CODE_PATH="../../../process_data/remove_duplicate_rows.py"

for f in *.csv;
do
    OUT_FILE_PATH="$OUT_DIR"/"${f%.csv}_no_dup.csv"
    python3 $CODE_PATH $f $OUT_FILE_PATH
done