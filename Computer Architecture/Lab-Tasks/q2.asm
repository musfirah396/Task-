global _main
extern _printf

section .data

; %08X displays an 8-digit hexadecimal value.
format db "EAX = 0x%08X", 10, 0

section .text

_main:
    ; EAX is a 32-bit CPU register.
    ; Store hexadecimal 12345678 inside it.
    mov eax, 0x12345678

    ; Push the number that printf will display.
    push eax

    ; Push the address of the format string.
    push format

    ; Display the result.
    call _printf

    ; Remove the two parameters from the stack.
    add esp, 8

    ; Return 0.
    xor eax, eax
    ret
