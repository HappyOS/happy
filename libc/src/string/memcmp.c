#include <string.h>

int memcmp(const void *m1, const void *m2, size_t count) {
    const char *mm1 = (const char *) m1;
    const char *mm2 = (const char *) m2;

    while (count--) {
        if (*mm1 != *mm2)
            return *mm1 - *mm2;

        mm1++;
        mm2++;
    }

    return 0;
}