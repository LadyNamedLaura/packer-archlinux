#!/bin/bash

set -x
cd /mnt

useradd -R /mnt -m vagrant
echo "vagrant:vagrant" | chpasswd -R /mnt

cat << EOF > etc/sudoers.d/10_vagrant
Defaults:vagrant !requiretty
Defaults:vagrant env_keep += "SSH_AUTH_SOCK"
vagrant        ALL=(ALL)       NOPASSWD: ALL
EOF
chmod 0440 /etc/sudoers.d/10_vagrant

mkdir home/vagrant/.ssh
curl 'https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub' > home/vagrant/.ssh/authorized_keys

chown -R 1000:1000 home/vagrant/.ssh
chmod 700 home/vagrant/.ssh
chmod 600 home/vagrant/.ssh/authorized_keys
