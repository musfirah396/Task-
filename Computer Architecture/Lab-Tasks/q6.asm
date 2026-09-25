global _main
extern _printf

section .data

format db "EAX = %d, EBX = %d", 10, 0

section .text

_main:
    ; Store 10 inside EAX.
    mov eax, 10

    ; Store 20 inside EBX.
    mov ebx, 20

    ; Add EBX to EAX.
    add eax, ebx

    ; EAX now contains 30.
    ; EBX still contains 20.
    push ebx
    push eax
    push format
    call _printf
    add esp, 12

    xor eax, eax
    ret
