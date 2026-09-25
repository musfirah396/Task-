global _main
extern _printf

section .data

format db "10 + 5 = %d", 10, 0

section .text

_main:
    ; Start with 10.
    mov al, 10

    ; Add 5 to AL.
    add al, 5

    ; AL now contains 15.
    ; Convert the 8-bit result to 32 bits.
    movzx eax, al

    push eax
    push format
    call _printf
    add esp, 8

    xor eax, eax
    ret
