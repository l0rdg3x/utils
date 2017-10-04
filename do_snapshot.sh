#!/bin/bash

BTRFS_ROOT=/dev/sdb3
MOUNT_ROOT=/mnt/root

if [ ! -d "$MOUNT_ROOT" ]; then
    # On first execute, create MOUNT_ROOT dir
    sudo mkdir $MOUNT_ROOT
else
    echo "Skip creation of root folder"
fi

if [ ! "$(ls -A "$MOUNT_ROOT")" ]; then
    # If MOUNT_ROOT is empty then mount BTRFS_ROOT in MOUNT_ROOT
    sudo mount $BTRFS_ROOT $MOUNT_ROOT
else
    # Skip mount
    echo "Skip mount"
fi

cd $MOUNT_ROOT

if [ ! -d "@$(date +%F_%H-%M)" ]; then
    sudo btrfs subvolume snapshot ./@ ./@$(date +%F_%H-%M)
else
    # Already exist a snapshot with same date and time
    echo "Skip root snapshot"
fi

if [ ! -d "@home$(date +%F_%H-%M)" ]; then
    sudo btrfs subvolume snapshot ./@home ./@home$(date +%F_%H-%M)
else
    # Already exist a snapshot with same date and time
    echo "Skip home snapshot"
fi

cd ~
sleep 1
sudo umount $MOUNT_ROOT
