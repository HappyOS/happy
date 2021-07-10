#include "VGAConsole.h"
#include <stdint.h>
#include <string.h>

int VGAConsole::cursor_x = 0;
int VGAConsole::cursor_y = 0;
int VGAConsole::width = 80;
int VGAConsole::height = 25;

uint16_t *VGAConsole::screen = (uint16_t *) 0xffffffff800b8000;

void VGAConsole::putch(char ch) {
    if (ch == '\n') {
        cursor_x = 0;
        cursor_y++;
    } else {
        screen[cursor_y * width + cursor_x] = ch | (0x0f << 8);
        cursor_x++;
    }

    if (cursor_x >= width) {
        cursor_x = 0;
        cursor_y++;
    }

    if (cursor_y >= height) {
        memcpy(screen, screen + width * 2, (height - 1) * width * 2);
        memset(screen + (height - 1) * width, 0, width * 2);
    }
}
