#!/bin/bash

# Prompt for user credentials
read -p "Enter the User Name : " UserName
read -s "Enter the Pass Word : " Password
echo
read -p "Enter server address (hostname or IP): " server_address

#Login
ssh -p 2222 "$username@$server_address" << EOF

cp /home/path1/file1 /home/path2/file1

cd /home/path2/
if [ -f file1 ]; then
    echo "file copied"
else 
    echo "file not copied"

EOF