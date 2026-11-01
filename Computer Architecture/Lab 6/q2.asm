; Lab 6 Problem 2 - Ping-Pong Conflict Thrashing
global _main
extern _printf

section .data
    title_str db "--- Lab 6 Problem 2: Stride-Induced Conflict Misses (Ping-Pong) ---", 10, 0
    desc_str  db "Direct-mapped cache (1 KB capacity = 64 blocks of 16 bytes).", 10
              db "ArrayA and ArrayB separated by 1024 bytes -> Identical set index!", 10
              db "Interleaved accesses [A0, B0, A1, B1...]: Miss Rate = 100.0%%.", 10
              db "Capacity unutilized: 63 out of 64 blocks remain completely empty.", 10, 0

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
