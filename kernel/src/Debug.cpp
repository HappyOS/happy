#include "VGAConsole.h"
#include <stdint.h>
#include <stdarg.h>

void unsigned_number_to_string(uint64_t number, int base, char *buffer) {
    if (number == 0) {
        *buffer++ = '0';
        *buffer = 0;
        return;
    }

    char buf[65];
    for (int i = 0; i < 65; i++)
        buf[i] = 0;

    int cur = 0;

    while (number) {
        int digit = number % base;
        if (digit >= 10) {
            buf[cur++] = 'a' + (digit - 10);
        } else {
            buf[cur++] = '0' + digit;
        }

        number /= base;
    }

    for (int i = cur - 1; i != 0; i--)
        *buffer++ = buf[i];
    *buffer++ = buf[0];
    *buffer = 0;
}

void number_to_string(int64_t number, int base, char *buffer) {
    if (number < 0) {
        *buffer++ = '-';
        number = -number;
    }

    unsigned_number_to_string(number, base, buffer);
}

// State:
//  0: regular
//  1: escape
void vprintk(const char *fmt, va_list args) {
    int state = 0;
    int is_long = 0;
    int can_reset = 1;

    char number_buffer[65];

    while (*fmt) {
        if (state == 0) {
            if (*fmt == '%') {
                state = 1;
            } else {
                VGAConsole::putch(*fmt);
            }
        } else if (state == 1) {
            switch (*fmt) {
                case 'c': {
                    char ch = va_arg(args, int);
                    VGAConsole::putch(ch);
                    break;
                }
                case 's': {
                    const char *s = va_arg(args, const char *);
                    while (*s) {
                        VGAConsole::putch(*s++);
                    }
                    break;
                }
                case 'l': {
                    is_long = 1;
                    can_reset = 0;
                    break;
                }
                case 'd': {
                    int64_t n;
                    if (is_long == 1) {
                        n = va_arg(args, long);
                    } else {
                        n = va_arg(args, int);
                    }

                    number_to_string(n, 10, number_buffer);
                    for (int i = 0; number_buffer[i]; i++) {
                        VGAConsole::putch(number_buffer[i]);
                    }
                    break;
                }
                case 'x': {
                    uint64_t n;
                    if (is_long == 1) {
                        n = va_arg(args, unsigned long);
                    } else {
                        n = va_arg(args, unsigned int);
                    }

                    unsigned_number_to_string(n, 16, number_buffer);
                    for (int i = 0; number_buffer[i]; i++) {
                        VGAConsole::putch(number_buffer[i]);
                    }
                    break;
                }
                case 'p': {
                    VGAConsole::putch('0');
                    VGAConsole::putch('x');

                    void *n = va_arg(args, void *);

                    unsigned_number_to_string((uint64_t) n, 16, number_buffer);
                    for (int i = 0; number_buffer[i]; i++) {
                        VGAConsole::putch(number_buffer[i]);
                    }

                    break;
                }
            }

            if (can_reset == 1) {
                state = 0;
                is_long = 0;
            } else {
                can_reset = 1;
            }
        }

        fmt++;
    }
}

void printk(const char *fmt, ...) {
    va_list args;
    va_start(args, fmt);

    vprintk(fmt, args);

    va_end(args);
}