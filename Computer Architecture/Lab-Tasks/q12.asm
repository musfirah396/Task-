global _main
extern _printf

section .data

format db "Result = %d", 10, 0

section .text

_main:
    ; Decimal 5:
    ; 00000101
    mov al, 5

    ; Decimal 8:
    ; 00001000
    or al, 8

    ; Result:
    ; 00001101
    ; Decimal 13.
    movzx eax, al

    push eax
    push format
    call _printf
    add esp, 8

    xor eax, eax
    ret
