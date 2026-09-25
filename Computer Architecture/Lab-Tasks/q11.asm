global _main
extern _printf

section .data

format db "Result = 0x%02X", 10, 0

section .text

_main:
    ; AA in binary is:
    ; 10101010
    mov al, 0xAA

    ; 0F in binary is:
    ; 00001111
    and al, 0x0F

    ; Result:
    ; 00001010
    ; This is hexadecimal 0A.
    movzx eax, al

    push eax
    push format
    call _printf
    add esp, 8

    xor eax, eax
    ret
