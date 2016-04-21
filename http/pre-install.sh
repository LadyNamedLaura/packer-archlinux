#!/usr/bin/env bash

vagrant_passwd='vagrant'
root_passwd='changeme'

echo "Status: Setting the vagrant root passwd to $root_passwd"
echo "root:$root_passwd" | chpasswd

echo "Status: Adding the vagrant user"
/usr/bin/useradd -d /home/vagrant -G wheel -m vagrant

echo "Status: Setting the vagrant user passwd to $vagrant_passwd"
echo "vagrant:$vagrant_passwd" | chpasswd

echo "Status: Configuring sudo for vagrant user"
cat > /etc/sudoers.d/10_vagrant << EOF
Defaults:vagrant !requiretty
  vagrant ALL=(ALL) NOPASSWD: ALL
EOF

echo "Status: Enableing sshd"
systemctl start sshd

