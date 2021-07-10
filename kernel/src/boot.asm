section .multiboot

; The header defined in https://www.gnu.org/software/grub/manual/multiboot/multiboot.html
; Section 3.1

; Signature
dd 0x1badb002
; Flags (page-align, memory info)
dd 3
; Checksum
dd -(0x1badb002 + 3)

bits 32
section .text.entry

; The kernel entry point at boot
global start
start:
    cli
    hlt