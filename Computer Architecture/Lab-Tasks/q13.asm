global _main
extern _printf

section .data

equalMessage db "The numbers are equal.", 10, 0
notEqualMessage db "The numbers are not equal.", 10, 0

section .text

_main:
    mov al, 10
    mov bl, 10

    ; CMP internally performs:
    ; AL - BL

    ; The result is not stored.
    ; CPU flags are updated instead.
    cmp al, bl

    ; JE means Jump if Equal.
    ; It checks the Zero Flag.
    je numbers_are_equal

numbers_are_not_equal:
    push notEqualMessage
    call _printf
    add esp, 4
    jmp finished

numbers_are_equal:
    push equalMessage
    call _printf
    add esp, 4

finished:
    xor eax, eax
    ret
