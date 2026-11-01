; Lab 5 Task 11 - Power-of-Two Stride Pathologies
global _main
extern _printf

section .data
    title_msg db "--- Lab 5 Task 11: Power-of-Two Stride Pathologies ---", 10, 0
    desc_msg  db "Stride S = 1024 B (2^10): Touches only Set 0, 16, 32... 93.75%% of sets idle!", 10
              db "Stride S = 1028 B (1024+4): Rotates through all 256 sets (100%% utilization).", 10
              db "Elapsed cycles: S=1024 -> %u cycles | S=1028 -> %u cycles", 10, 0

    align 64
    buf_p2 times 32768 dd 1

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

    ; S=1024
    rdtsc
    mov esi, eax

    mov edx, 100
.rep1:
    xor eax, eax
    xor ecx, ecx
.l1:
    add eax, [buf_p2 + ecx*4]
    add ecx, 256
    and ecx, 32767
    dec edx
    jnz .l1

    rdtsc
    sub eax, esi
    mov edi, eax

    ; S=1028
    rdtsc
    mov esi, eax

    mov edx, 100
.rep2:
    xor eax, eax
    xor ecx, ecx
.l2:
    add eax, [buf_p2 + ecx*4]
    add ecx, 257
    and ecx, 32767
    dec edx
    jnz .l2

    rdtsc
    sub eax, esi

    push eax
    push edi
    push desc_msg
    call _printf
    add esp, 12

    pop edi
    pop esi
    pop ebx
    xor eax, eax
    mov esp, ebp
    pop ebp
    ret
