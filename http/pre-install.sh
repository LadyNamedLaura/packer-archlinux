#!/usr/bin/env bash

root_passwd='changeme'

echo "Status: Setting the vagrant root passwd to $root_passwd"
echo "root:$root_passwd" | chpasswd

echo "Status: Starting sshd"
systemctl start sshd

