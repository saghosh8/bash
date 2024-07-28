# Scenario: Monitoring Disk Usage
# Question: Write a Bash script to monitor the disk usage of the root filesystem and send an alert if the usage exceeds 80%.

#!/bin/bash

usage=$(df / | grep / | awk '{ print $5 }' | sed 's/%//g')

if [ $usage -gt 80 ]; then
    echo "Disk usage is above 80%."
    # Here you could add code to send an email or notification
fi
