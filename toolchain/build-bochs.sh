#!/bin/bash

set -e

OS=$(uname)

if [ "$OS" == "Darwin" ]; then
	extra_flags="--with-sdl2"
else
	extra_flags="--with-x11"
	echo "Ensure you have libx11-dev installed"
fi

echo "Bochs 2.7.pre1 will be downloaded and compiled for your machine"
echo "At the end your password will be required to complete the installation"
echo "Press [enter] to continue"
read -s

curl -L -O  http://downloads.sourceforge.net/project/bochs/bochs/2.7.pre1/bochs-2.7.pre1.tar.gz
tar xvf bochs-2.7.pre1.tar.gz
rm bochs-2.7.pre1.tar.gz

pushd bochs-2.7.pre1

./configure --enable-idle-hack --enable-plugins --enable-x86-64 --enable-smp --enable-large-ramfile --enable-repeat-speedups --enable-fast-function-calls --enable-handlers-chaining --enable-trace-linking --enable-debugger --enable-all-optimizations --enable-readline --disable-stats --enable-assert-checks --enable-protection-keys --enable-memtype --enable-avx --enable-x86-debugger --enable-pcidev --enable-usb --enable-usb-ohci --enable-usb-ehci --enable-usb-xhci --enable-ne2000 --enable-pnic --enable-e1000 --enable-raw-serial --enable-clgd54xx --enable-voodoo --enable-cdrom --enable-sb16 --enable-es1370 --enable-gameport --enable-busmouse --disable-docbook --disable-xpm $extra_flags

make -j$(nproc)
sudo make install

popd

