#!bin/bash

# extracts all zip files and rename them to zip_file_name.csv

TMP_DIR="__temp__"

mkdir $TMP_DIR
for f in *.zip;
do
    unzip "$f" -d $TMP_DIR && mv $TMP_DIR/* "${f%.zip}.csv"; 
done

rmdir $TMP_DIR