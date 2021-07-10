#include <string.h>

void *memcpy(void *destination, const void *source, size_t count) {
    char *d = (char *) destination;
    const char *s = (char *) source;

    while (count--) {
        *d++ = *s++;
    }

    return destination;
}