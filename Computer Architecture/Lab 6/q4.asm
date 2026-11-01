; Lab 6 Problem 4 - Row-Major vs Column-Major Traversal
global _main
extern _printf

section .data
    title_str db "--- Lab 6 Problem 4: Matrix Traversal (Row vs Column Major) ---", 10, 0
    desc_str  db "16x16 Matrix (1024 bytes) on 512-byte direct-mapped cache (16 lines x 32 bytes):", 10
              db "  Row-Major (stride 1 word)    : 32 misses, 224 hits (87.5%% Hit Rate)", 10
              db "  Column-Major (stride 16 words): 256 misses, 0 hits   (  0.0%% Hit Rate - 100%% thrashing)", 10
              db "Cycles: Row-Major = %u | Column-Major = %u", 10, 0

    align 64
    grid times 256 dd 1

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

    ; Row
    rdtsc
    mov esi, eax
    xor eax, eax
    xor ecx, ecx
.r_l:
    add eax, [grid + ecx*4]
    inc ecx
    cmp ecx, 256
    jl .r_l
    rdtsc
    sub eax, esi
    mov edi, eax

    ; Col
    rdtsc
    mov esi, eax
    xor eax, eax
    xor edx, edx
.c_o:
    xor ecx, ecx
.c_i:
    mov ebx, ecx
    shl ebx, 4
    add ebx, edx
    add eax, [grid + ebx*4]
    inc ecx
    cmp ecx, 16
    jl .c_i
    inc edx
    cmp edx, 16
    jl .c_o
    rdtsc
    sub eax, esi

    push eax
    push edi
    push desc_str
    call _printf
    add esp, 12

    pop edi
    pop esi
    pop ebx
    xor eax, eax
    mov esp, ebp
    pop ebp
    ret
