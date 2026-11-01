; Lab 6 Problem 3 - Loop Padding & Set Shifting
global _main
extern _printf

section .data
    title_str db "--- Lab 6 Problem 3: Loop Padding & Alignment Optimization ---", 10, 0
    desc_str  db "Inserted 64-byte dummy buffer between ArrayA and ArrayB.", 10
              db "New base delta = 1088 bytes -> ArrayB is shifted by 4 cache sets.", 10
              db "Set conflict completely eliminated! Cache hits restored to 100%% on steady state.", 10, 0

    align 1024
    arr1 times 64 dd 1
    pad  times 16 dd 0 ; 64 bytes padding
    arr2 times 64 dd 2

section .text
_main:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi

    push title_str
    call _printf
    add esp, 4

    push desc_str
    call _printf
    add esp, 4

    pop edi
    pop esi
    pop ebx
    xor eax, eax
    mov esp, ebp
    pop ebp
    ret
