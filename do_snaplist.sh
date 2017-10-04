#!/bin/bash

BTRFS_ROOT=/dev/sdb3
MOUNT_ROOT=/mnt/root

if [ ! "$(ls -A "$MOUNT_ROOT")" ]; then
    # If MOUNT_ROOT is empty then mount BTRFS_ROOT in MOUNT_ROOT
    sudo mount $BTRFS_ROOT $MOUNT_ROOT
else
    # Skip mount
    echo "Skip mount"
fi

cd $MOUNT_ROOT

sudo btrfs subvolume list .

cd ~
sleep 1
sudo umount $MOUNT_ROOT
