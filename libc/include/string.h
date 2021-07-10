#ifndef _STRING_H
#define _STRING_H

typedef __SIZE_TYPE__ size_t;

#ifdef __cplusplus
extern "C" {
#endif

void *memcpy(void *destination, const void *source, size_t count);
void *memmove(void *destination, const void *source, size_t count);
int memcmp(const void *m1, const void *m2, size_t count);
void *memset(void *destination, int value, size_t count);

#ifdef __cplusplus
}
#endif

#endif
