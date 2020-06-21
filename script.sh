#!/bin/bash 

# $1=file to parition 
# $2=number of partitions
# $3=dir to place partitions 

mkdir $3 && cp $1 ./$3/tmp_source_file && cd $3
HEADER_COLUMNS=$(head -n 1 tmp_source_file)
echo "$(sed "1d" tmp_source_file)" > tmp_source_file 
NUMBER_OF_LINES=$(wc -l tmp_source_file | grep -E -o -e "[0-9]+")
LINES_IN_EACH_FILE=$((NUMBER_OF_LINES/$2 + 1))
split -l $LINES_IN_EACH_FILE tmp_source_file splitfile_
rm tmp_source_file
for filename in ./* 
do 
	echo "$(echo $HEADER_COLUMNS | cat - $filename)" > $filename
done 	

