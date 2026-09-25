global _main
extern _printf

section .data

format db "AL = %d, BL = %d", 10, 0

section .text

_main:
    ; Store 10 in AL.
    mov al, 10

    ; Store 20 in BL.
    mov bl, 20

    ; Add the contents of BL to AL.
    add al, bl

    ; AL now contains 30.
    ; BL still contains 20.
    movzx ecx, bl
    movzx eax, al

    push ecx
    push eax
    push format
    call _printf
    add esp, 12

    xor eax, eax
    ret
