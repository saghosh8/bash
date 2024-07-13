#!/bin/bash

# Prompt for user credentials
read -p "Enter server username: " username
read -sp "Enter server password: " password
echo
read -p "Enter server address (hostname or IP): " server_address

# SSH into the server, start the JBoss process, and check if it's completely started
sshpass -p "$password" ssh -o StrictHostKeyChecking=no "$username@$server_address" << EOF
  cd /path/to/jboss/bin
  echo "Navigated to $(pwd)"

  # Start the JBoss process
  echo "Starting JBoss..."
  ./jboss-cli.sh --connect --command=:start

  # Wait for a few seconds to allow the startup to complete
  sleep 10

  # Check if JBoss is running
  if ps -ef | grep -v grep | grep jboss > /dev/null; then
    echo "JBoss has been started."
  else
    echo "JBoss is not started."
  fi
EOF
