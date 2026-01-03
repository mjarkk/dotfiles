#!/bin/bash

set -e

sudo mkdir -p /mnt/encrypted_hdd
sudo cryptsetup luksOpen /dev/sda1 sda1_decrypted
echo "decrypted sda1"
sudo mount /dev/mapper/sda1_decrypted /mnt/encrypted_hdd
echo "mounted sda1"

sudo systemctl start jellyfin
sudo systemctl start smbd
