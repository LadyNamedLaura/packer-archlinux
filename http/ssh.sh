#!/bin/bash

echo "root:changeme" | chpasswd
systemctl start sshd
