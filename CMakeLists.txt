set(CMAKE_C_COMPILER_WORKS 1)
set(CMAKE_CXX_COMPILER_WORKS 1)

cmake_minimum_required(VERSION 3.16)
project(happy-kernel LANGUAGES C CXX)

set(CMAKE_ASM_NASM_OBJECT_FORMAT elf64)
enable_language(ASM_NASM)

set(CMAKE_SYSTEM_NAME x86_64)
set(CMAKE_SYSTEM_VERSION latest)

set(CMAKE_C_COMPILER x86_64-elf-gcc)
set(CMAKE_CXX_COMPILER x86_64-elf-g++)
set(CMAKE_CXX_STANDARD 20)

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

add_subdirectory(kernel)

add_custom_command(
    OUTPUT ${CMAKE_SOURCE_DIR}/disk.img
    COMMAND cd ${CMAKE_SOURCE_DIR}/toolchain && ./mkimage.sh 1 ${CMAKE_SOURCE_DIR}/disk.img
)

add_custom_target(build-image
    DEPENDS ${CMAKE_SOURCE_DIR}/disk.img
)

add_custom_target(install-kernel
    COMMAND ${CMAKE_SOURCE_DIR}/toolchain/install.sh ${CMAKE_SOURCE_DIR}/disk.img
    DEPENDS kernel build-image
)

add_custom_target(bochs
    COMMAND bochs -q
    DEPENDS install-kernel
)

add_custom_target(qemu
    COMMAND qemu-system-x86_64
        -serial stdio
        -audiodev alsa,id=audioout
        -machine pcspk-audiodev=audioout
        -drive media=disk,file=${CMAKE_SOURCE_DIR}/disk.img,format=raw,index=0
    DEPENDS install-kernel
)