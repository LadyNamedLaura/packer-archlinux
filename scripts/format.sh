#!/bin/bash
set -x

DISK=/dev/sda

if [ ! -e "$DISK" ]
then
  DISK=/dev/vda
fi

ROOT_PARTITION="${DISK}1"
TARGET_DIR='/mnt'

sgdisk ${DISK} --zap-all -o
sgdisk ${DISK} --new=1:0:0 --attributes=1:set:2
mkfs.ext4 -F -m 0 -q -L root ${ROOT_PARTITION}
mount -o noatime,errors=remount-ro ${ROOT_PARTITION} ${TARGET_DIR}
