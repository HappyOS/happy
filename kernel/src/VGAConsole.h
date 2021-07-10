#pragma once

class VGAConsole {
public:
    static void putch(char ch);

private:
    static unsigned short *screen;

    static int cursor_x;
    static int cursor_y;

    static int width;
    static int height;
};