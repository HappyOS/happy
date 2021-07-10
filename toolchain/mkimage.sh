#!/bin/sh

set -e

if [ $# -ne 2 ]; then
    echo "Usage: mkimage.sh <number-of-gb> <filename>"
    exit
fi

if [ "$(id -u)" != 0 ]; then
    exec sudo -E -- "$0" "$@"
fi

dd if=/dev/zero of=$2 bs=1M count=$(($1 * 1024))
chown $SUDO_UID:$SUDO_GID $2

loop=$(losetup --find --partscan --show $2)

parted -s "${loop}" mklabel msdos mkpart primary ext2 2MiB 100% set 1 boot on

mke2fs -q "${loop}p1"

mkdir -p tmp
mount "${loop}p1" tmp

grub-install --boot-directory=tmp/boot --target=i386-pc --modules="ext2 part_msdos" "${loop}"
cp grub.cfg tmp/boot/grub/grub.cfg

sync
umount tmp
rmdir tmp
losetup -d "${loop}"

echo "For use with bochs, set CHS=$(($1 * 32768))/2/32"
