export TARGET=x86_64-elf
export CROSS_CC=$(TARGET)-gcc
export CROSS_CXX=$(TARGET)-g++

all:
	$(MAKE) -C kernel

disk.img:
	cd toolchain && ./mkimage.sh 1 $@

build-image: disk.img

install-kernel: build-image
	toolchain/install.sh disk.img

bochs: install-kernel
	bochs -q

qemu: install-kernel
	qemu-system-x86_64 \
        -serial stdio \
        -audiodev alsa,id=audioout \
        -machine pcspk-audiodev=audioout \
        -drive media=disk,file=disk.img,format=raw,index=0 \

clean:
	$(MAKE) -C kernel clean