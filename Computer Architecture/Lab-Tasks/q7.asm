global _main
extern _printf

section .data

format db "20 - 5 = %d", 10, 0

section .text

_main:
    ; Store 20 inside AL.
    mov al, 20

    ; Subtract 5.
    sub al, 5

    ; AL now contains 15.
    movzx eax, al

    push eax
    push format
    call _printf
    add esp, 8

    xor eax, eax
    ret
