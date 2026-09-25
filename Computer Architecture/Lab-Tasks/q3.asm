global _main
extern _printf

section .data

format db "AL = %d, BL = %d", 10, 0

section .text

_main:
    ; Store 10 inside AL.
    mov al, 10

    ; Copy AL into BL.
    mov bl, al

    ; Convert BL to a 32-bit value.
    ; Store it temporarily in ECX.
    movzx ecx, bl

    ; Convert AL to a 32-bit value.
    ; Store it in EAX.
    movzx eax, al

    ; printf arguments are pushed
    ; from right to left.
    push ecx
    push eax
    push format
    call _printf

    ; Three values were pushed.
    ; 3 x 4 = 12 bytes.
    add esp, 12

    xor eax, eax
    ret
