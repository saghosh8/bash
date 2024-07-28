# Scenario: Backing Up a Directory
# Question: Write a Bash script to create a backup of the "/var/www" directory, saving the backup in the "/backup" directory with a timestamp.

#!/bin/bash

timestamp=$(date +"%Y%m%d%H%M%S")
backup_dir="/backup"
src_dir="/var/www"
backup_file="$backup_dir/www_backup_$timestamp.tar.gz"

tar -czf "$backup_file" "$src_dir"
echo "Backup created at $backup_file."
