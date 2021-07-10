#include "VGAConsole.h"
#include <stdint.h>

void puts(const char *string) {
    while (*string) {
        VGAConsole::putch(*string++);
    }
}

void puthex(uint64_t number) {
    if (number == 0) {
        VGAConsole::putch('0');
        return;
    }

    char buf[17];
    for (int i = 0; i < 17; i++)
        buf[i] = 0;

    int cur = 0;

    while (number) {
        int digit = number % 16;
        if (digit >= 10) {
            buf[cur++] = 'a' + (digit - 10);
        } else {
            buf[cur++] = '0' + digit;
        }

        number /= 16;
    }

    for (int i = cur - 1; i != 0; i--)
        VGAConsole::putch(buf[i]);
    VGAConsole::putch(buf[0]);
}