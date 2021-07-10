add_executable(kernel src/main.cpp src/boot.asm)

target_link_options(kernel PRIVATE
    -Tsrc/linker.ld
    -nostdlib
    -z max-page-size=4096
    LINKER:--print-memory-usage
    LINKER:-Map,${CMAKE_CURRENT_BINARY_DIR}/kernel.map
)

target_link_libraries(kernel gcc)

add_compile_options(
    -Wall
    -Wextra
    -Werror
    -ffreestanding
    -fno-exceptions
    -fno-rtti
    -mno-red-zone
    -mcmodel=kernel
    -fno-pic
)
