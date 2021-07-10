ENTRY(start)

OFFSET = 0xffffffff80000000;

SECTIONS {
    . = OFFSET + 0x100000;

    kernel_image_start = .;

    .text : AT(ADDR(.text) - OFFSET) {
        *(.multiboot)
        *(.text.entry)
        *(.text)
        . = ALIGN(4096);
    }

    .rodata : AT(ADDR(.rodata) - OFFSET) {
        *(.rodata)
        . = ALIGN(4096);
    }

    .data : AT(ADDR(.data) - OFFSET) {
        *(.data)
        . = ALIGN(4096);
    }

    .bss : AT(ADDR(.bss) - OFFSET) {
        *(.bss)
        . = ALIGN(4096);
    }

    kernel_image_end = .;

    /DISCARD/ : {
        *(.comment)
        *(.eh_frame)
        *(.COMMON)
    }
}