#!/bin/bash

set -x
cd /mnt

pacstrap . iproute2 iputils bzip2 e2fsprogs filesystem grep gzip linux pacman procps-ng psmisc sed systemd-sysvcompat tar vi sudo gptfdisk openssh syslinux nfs-utils

sed -i 's/sda3/vda1/' boot/syslinux/syslinux.cfg
sed -i 's/TIMEOUT 50/TIMEOUT 3/' boot/syslinux/syslinux.cfg
arch-chroot . syslinux-install_update -i -a -m

genfstab -p . >> etc/fstab

echo 'en_US.UTF-8 UTF-8' >> etc/locale.gen
arch-chroot . locale-gen

sed  -i 's/^HOOKS.*$/HOOKS="base systemd autodetect modconf block filesystems keyboard fsck"/' etc/mkinitcpio.conf
arch-chroot . mkinitcpio -p linux

systemctl --root . enable rpcbind.socket 

sed -i 's/#UseDNS yes/UseDNS no/' etc/ssh/sshd_config
systemctl --root . enable sshd.service
mkdir -p etc/systemd/network
cat << EOF > etc/systemd/network/99-dhcp.network
[Match]

[Network]
DHCP=both
LinkLocalAddressing=yes
LLDP=yes
LLMNR=yes
EOF
systemctl --root . enable systemd-networkd systemd-resolved

rm etc/resolv.conf
ln -s /run/systemd/resolve/resolv.conf etc/resolv.conf

