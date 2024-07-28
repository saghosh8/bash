# Scenario: Processing a List of Files
# Question: Write a Bash script to iterate over all ".log" files in the current directory and print the number of lines in each file.


#!/bin/bash

for file in *.log; do
    if [ -f "$file" ]; then
        line_count=$(wc -l < "$file")
        echo "$file has $line_count lines."
    fi
done
