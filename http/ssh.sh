#!/bin/bash

echo 'Status: Set the password for root to "changeme".'
echo "root:changeme" | chpasswd

echo 'Status: Start sshd.'
systemctl start sshd
