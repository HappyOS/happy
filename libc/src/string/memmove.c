#include <string.h>

void *memmove(void *destination, const void *source, size_t count) {
    if (destination < source) {
        return memcpy(destination, source, count);
    }

    // Copy backwards

    char *d = (char *) destination + count;
    const char *s = (char *) source + count;

    while (count--) {
        *d-- = *s--;
    }

    return destination;
}