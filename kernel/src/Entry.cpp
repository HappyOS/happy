#include "Utils.h"
#include <stdint.h>

extern "C" [[noreturn]] void entry(void *multiboot_info) {
    puts("Hello world!\n");

    puthex((uint64_t) multiboot_info);

    while (true)
        ;
}