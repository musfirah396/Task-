; Lab 5 Task 17 - Software Prefetching
global _main
extern _printf

section .data
    title_msg db "--- Lab 5 Task 17: Software Data Prefetching Optimization ---", 10, 0
    desc_msg  db "16,384 Elements Array Walk:", 10
              db "  Unprefetched Baseline : %u cycles (Sum = %d)", 10
              db "  Prefetched (K=32 ahead): %u cycles (Sum = %d)", 10
              db "Prefetching hides DRAM fetch latencies.", 10, 0

    align 64
    pf_arr times 16384 dd 3

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

    ; Baseline
    rdtsc
    mov esi, eax

    xor eax, eax
    xor ecx, ecx
.l_un:
    add eax, [pf_arr + ecx*4]
    inc ecx
    cmp ecx, 16384
    jl .l_un

    rdtsc
    sub eax, esi
    mov edi, eax

    ; Prefetched
    rdtsc
    mov esi, eax

    xor eax, eax
    xor ecx, ecx
.l_pf:
    prefetcht0 [pf_arr + ecx*4 + 128]
    add eax, [pf_arr + ecx*4]
    inc ecx
    cmp ecx, 16384
    jl .l_pf

    rdtsc
    sub eax, esi

    push 49152
    push eax
    push 49152
    push edi
    push desc_msg
    call _printf
    add esp, 20

    pop edi
    pop esi
    pop ebx
    xor eax, eax
    mov esp, ebp
    pop ebp
    ret
