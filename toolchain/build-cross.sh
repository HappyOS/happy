#!/bin/bash

set -e

BINUTILS_VERSION=2.36
GCC_VERSION=11.1.0
GMP_VERSION=6.2.1
MPC_VERSION=1.2.1
MPFR_VERSION=4.1.0
LIBICONV_VERSION=1.16

curl -O https://ftp.gnu.org/gnu/binutils/binutils-$BINUTILS_VERSION.tar.gz
curl -O https://ftp.gnu.org/gnu/gcc/gcc-$GCC_VERSION/gcc-$GCC_VERSION.tar.gz
curl -O https://ftp.gnu.org/gnu/gmp/gmp-$GMP_VERSION.tar.bz2
curl -O https://ftp.gnu.org/gnu/mpc/mpc-$MPC_VERSION.tar.gz
curl -O https://ftp.gnu.org/gnu/mpfr/mpfr-$MPFR_VERSION.tar.gz
curl -O https://ftp.gnu.org/gnu/libiconv/libiconv-$LIBICONV_VERSION.tar.gz

tar xf binutils-$BINUTILS_VERSION.tar.gz
tar xf gcc-$GCC_VERSION.tar.gz
tar xf gmp-$GMP_VERSION.tar.bz2
tar xf mpc-$MPC_VERSION.tar.gz
tar xf mpfr-$MPFR_VERSION.tar.gz
tar xf libiconv-$LIBICONV_VERSION.tar.gz

rm binutils-*.gz gcc-*.gz gmp-*.bz2 mpc-*.gz mpfr-*.gz libiconv-*.gz

rm -fr build-binutils build-gcc
mkdir build-binutils build-gcc
mv gmp-$GMP_VERSION gcc-$GCC_VERSION/gmp
mv mpc-$MPC_VERSION gcc-$GCC_VERSION/mpc
mv mpfr-$MPFR_VERSION gcc-$GCC_VERSION/mpfr
mv libiconv-$LIBICONV_VERSION gcc-$GCC_VERSION/libiconv

patch -s -p0 < gcc-$GCC_VERSION.patch

echo -n "Where do you want to have your toolchain installed? [$(pwd)] "
read PREFIX
if [ -z $PREFIX ]; then
    PREFIX=$(pwd)
fi

export PREFIX
export TARGET=x86_64-elf

pushd build-binutils

../binutils-$BINUTILS_VERSION/configure --prefix=$PREFIX --target=$TARGET --disable-nls --with-sysroot
time make -j$(nproc)
sleep 5
make install

popd

export PATH=$PREFIX/bin:$PATH

pushd build-gcc

../gcc-$GCC_VERSION/configure --prefix=$PREFIX --target=$TARGET --disable-nls --without-headers --enable-languages=c,c++
time make -j$(nproc) all-gcc
make -j$(nproc) all-target-libgcc
make install-gcc install-target-libgcc

popd

echo "🎉"