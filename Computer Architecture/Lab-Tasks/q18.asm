global _main
extern _printf

section .data

; Create one byte containing 10.
number db 10
format db "New memory value = %d", 10, 0

section .text

_main:
    ; Put 5 into BL.
    mov bl, 5

    ; Add BL to the byte stored in memory.
    ;
    ; Memory initially contains 10.
    ; BL contains 5.
    ;
    ; 10 + 5 = 15
    add byte [number], bl

    ; Read the new memory value.
    movzx eax, byte [number]

    push eax
    push format
    call _printf
    add esp, 8

    xor eax, eax
    ret
