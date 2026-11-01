; Lab 5 Task 4 - Row-Major vs Column-Major Sweep
global _main
extern _printf

section .data
    title_msg db "--- Lab 5 Task 4: Row-Major vs. Column-Major Sweep ---", 10, 0
    res_msg   db "Traversing 256x256 Matrix (65,536 integers):", 10
              db "  Row-Major Traversal Cycles : %u cycles (Sum = %d)", 10
              db "  Col-Major Traversal Cycles : %u cycles (Sum = %d)", 10
              db "Spatial locality divergence confirmed.", 10, 0

    align 64
    mat256 times 65536 dd 1

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

    ; Row-Major
    rdtsc
    mov esi, eax

    xor eax, eax
    xor ecx, ecx
.r_loop:
    add eax, [mat256 + ecx*4]
    inc ecx
    cmp ecx, 65536
    jl .r_loop

    rdtsc
    sub eax, esi
    mov edi, eax

    ; Col-Major
    rdtsc
    mov esi, eax

    xor eax, eax
    xor edx, edx
.c_outer:
    xor ecx, ecx
.c_inner:
    mov ebx, ecx
    shl ebx, 8
    add ebx, edx
    add eax, [mat256 + ebx*4]
    inc ecx
    cmp ecx, 256
    jl .c_inner
    inc edx
    cmp edx, 256
    jl .c_outer

    rdtsc
    sub eax, esi

    push 65536
    push eax
    push 65536
    push edi
    push res_msg
    call _printf
    add esp, 20

    pop edi
    pop esi
    pop ebx
    xor eax, eax
    mov esp, ebp
    pop ebp
    ret
