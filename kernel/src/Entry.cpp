#include "Utils.h"
#include <stdint.h>

extern "C" [[noreturn]] void entry(void *) {
    printk("Hello world! Now with numbers: %d!\n", 42);

    uint64_t n = (uint64_t)-1;
    printk("Largest 64bit: %ld, %lx\n", n, n);

    while (true)
        ;
}