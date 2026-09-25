global _main
extern _printf

section .data

; Reserve one byte in memory.
; Its starting value is 0.
number db 0
format db "Value in memory = %d", 10, 0

section .text

_main:
    ; Store decimal 42 at the memory
    ; location called number.
    mov byte [number], 42

    ; Read the byte from memory and
    ; convert it to a 32-bit value.
    movzx eax, byte [number]

    push eax
    push format
    call _printf
    add esp, 8

    xor eax, eax
    ret
