#!/bin/bash

# Need to be tested

BTRFS_ROOT=/dev/sdb3
MOUNT_ROOT=/mnt/root

if [ $# -gt 1 ]; then
    echo "Too much arguments"
elif [ ! $# -eq 1 ]; then
    echo "Missing argument"
fi

SNAP=$1

echo $1

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

if [ -d $SNAP ]; then
    # snapshot exists, let's rollback
    sudo mv ./@ ./@_badroot
    sudo mv ./$SNAP ./@
    echo "Reboot required"
else
    echo "Snapshot doesn't exist"
fi

cd ~
sleep 1
sudo umount $MOUNT_ROOT
