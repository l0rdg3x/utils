#!/bin/bash

BTRFS_ROOT=/dev/sdb3

sudo mount $BTRFS_ROOT /mnt/root
cd /mnt/root/
sudo btrfs subvolume snapshot ./@ ./@$(date +%F_%H-%M)
sudo btrfs subvolume snapshot ./@home ./@home$(date +%F_%H-%M)
cd ~
sleep 10
sudo umount /mnt/root
