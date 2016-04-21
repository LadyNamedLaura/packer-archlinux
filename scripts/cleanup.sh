#!/bin/bash

set -x
cd /mnt

pacman --root . -Rcns --noconfirm gptfdisk
pacman --root . -Scc --noconfirm
