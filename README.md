# Happy OS

## Building

Build a cross-compiling toolchain:

```
cd toolchain
./build-cross.sh
```

Now you can build the kernel and the needed libraries with

`make all`

To generate a bootable disk image:

`make install-kernel`

## Running in qemu

`make qemu`