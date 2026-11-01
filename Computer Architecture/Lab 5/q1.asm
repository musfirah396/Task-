; Lab 5 Task 1 - Spatial Locality (1024 Ints Contiguous Walk)
global _main
extern _printf

section .data
    title_msg db "--- Lab 5 Task 1: Spatial Locality via Contiguous Walk ---", 10, 0
    stat_msg  db "Array specification: N = 1024 elements (4096 Bytes total).", 10
              db "Line Size = 64 Bytes -> Compulsory Misses = 64.", 10
              db "Theoretical Miss Rate = 64/1024 = 6.25%% (93.75%% hit rate).", 10
              db "Execution sum = %d (Expected: %d).", 10, 0

    align 64
    buf_1024 times 1024 dd 5

section .text
_main:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi

    push title_msg
    call _printf
    add esp, 4

    xor eax, eax
    xor ecx, ecx
.sum_walk:
    add eax, [buf_1024 + ecx*4]
    inc ecx
    cmp ecx, 1024
    jl .sum_walk

    push 5120
    push eax
    push stat_msg
    call _printf
    add esp, 12

    pop edi
    pop esi
    pop ebx
    xor eax, eax
    mov esp, ebp
    pop ebp
    ret
