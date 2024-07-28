# Scenario: Checking for a File and Taking Action
# Question: Write a Bash script to check if a file named "example.txt" exists in the current directory. 
# If it exists, print "File exists." Otherwise, create the file and print "File created."

#!/bin/bash

if [ -f "example.txt" ]; then
    echo "File exists."
else
    touch "example.txt"
    echo "File created."
fi
