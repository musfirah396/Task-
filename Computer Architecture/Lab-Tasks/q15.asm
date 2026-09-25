global _main
extern _printf

section .data

format db "AL = %d, BL = %d", 10, 0

section .text

_main:
    mov al, 10
    mov bl, 20

    ; Before XCHG:
    ; AL = 10
    ; BL = 20
    xchg al, bl

    ; After XCHG:
    ; AL = 20
    ; BL = 10
    movzx ecx, bl
    movzx eax, al

    push ecx
    push eax
    push format
    call _printf
    add esp, 12

    xor eax, eax
    ret
