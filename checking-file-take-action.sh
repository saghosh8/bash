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

### EXPLANATION:
# The script checks for the existence of "example.txt". 
# If it exists, it prints a message saying so. If it doesn't exist, 
# it creates the file and prints a message indicating its creation.

# In essence, it ensures the file "example.txt" exists and 
# provides feedback to the user about the file's status.
