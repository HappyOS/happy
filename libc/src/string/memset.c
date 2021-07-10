#include <string.h>

void *memset(void *destination, int value, size_t count) {
    char *d = (char *) destination;
    char v = value & 0xff;

    while (count--) {
        *d++ = v;
    }

    return destination;
}