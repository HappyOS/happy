#!/bin/sh

set -e

if [ $# -ne 1 ]; then
    echo "Usage: install.sh <image>"
    exit
fi

if [ "$(id -u)" != 0 ]; then
    exec sudo -E -- "$0" "$@"
fi

loop=$(losetup --find --partscan --show $1)

mkdir -p tmp
mount "${loop}p1" tmp

cp kernel/kernel tmp/boot

cleanup() {
    sync && sleep 1 && umount tmp
}

cleanup || cleanup

rmdir tmp
losetup -d "${loop}"
