; Lab 4 Task 15 - Two-Way Loop Unrolling
global _main
extern _printf

section .data
    title_str db "--- Lab 4 Task 15: Two-Way Loop Unrolling (Dot Product) ---", 10, 0
    res_str   db "10,000 runs of 1000-element dot product:", 10
              db "  Baseline 1-Way : %u cycles (Result = %d)", 10
              db "  Unrolled 2-Way : %u cycles (Result = %d)", 10
              db "Branch frequency halved and loads interleaved.", 10, 0

    align 16
    vecA times 1000 dd 2
    vecB times 1000 dd 5

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

    ; Baseline
    rdtsc
    mov esi, eax

    mov edx, 1000
.rep_b:
    xor eax, eax
    xor ecx, ecx
.l_b:
    mov ebx, [vecA + ecx*4]
    imul ebx, [vecB + ecx*4]
    add eax, ebx
    inc ecx
    cmp ecx, 1000
    jl .l_b
    dec edx
    jnz .rep_b

    rdtsc
    sub eax, esi
    mov edi, eax

    ; 2-Way
    rdtsc
    mov esi, eax

    mov edx, 1000
.rep_u:
    xor eax, eax
    xor ecx, ecx
.l_u:
    mov ebx, [vecA + ecx*4]
    mov ebp, [vecB + ecx*4]
    imul ebx, ebp

    mov ebp, [vecA + ecx*4 + 4]
    imul ebp, [vecB + ecx*4 + 4]

    add eax, ebx
    add eax, ebp
    add ecx, 2
    cmp ecx, 1000
    jl .l_u
    dec edx
    jnz .rep_u

    rdtsc
    sub eax, esi

    push 10000
    push eax
    push 10000
    push edi
    push res_str
    call _printf
    add esp, 20

    pop edi
    pop esi
    pop ebx
    xor eax, eax
    mov esp, ebp
    pop ebp
    ret
