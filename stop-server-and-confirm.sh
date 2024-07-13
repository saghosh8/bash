#  Bash script that prompts the user for the server credentials, 
#  logs into the server, navigates to the directory containing the JBoss script, and 
#  checks if the application is completely stopped 

#!/bin/bash

# Prompt for user credentials
read -p "Enter server username: " username
read -sp "Enter server password: " password
echo
read -p "Enter server address (hostname or IP): " server_address

# SSH into the server, stop the JBoss process, and check if it's completely stopped
sshpass -p "$password" ssh -o StrictHostKeyChecking=no "$username@$server_address" << EOF
  cd /path/to/jboss
  echo "Navigated to $(pwd)"

  # Stop the JBoss process
  echo "Stopping JBoss..."
  ./jboss-cli.sh --connect command=:shutdown

  # Wait for a few seconds to allow the shutdown to complete
  sleep 10

  # Check if JBoss is completely stopped
  if ps -ef | grep -v grep | grep jboss > /dev/null; then
    echo "JBoss is still running."
  else
    echo "JBoss has been stopped."
  fi
EOF
