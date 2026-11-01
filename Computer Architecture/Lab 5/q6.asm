; Lab 5 Task 6 - AoS vs SoA Bandwidth Utilization
global _main
extern _printf

section .data
    title_msg db "--- Lab 5 Task 6: Structure of Arrays (SoA) vs Array of Structures (AoS) ---", 10, 0
    desc_msg  db "AoS Line Utilization: 16B useful / 64B line = 25%% (75%% bandwidth wasted).", 10
              db "SoA Line Utilization: 64B useful / 64B line = 100%% (Maximum efficiency).", 10
              db "Timing on 10,000 entities: AoS = %u cycles | SoA = %u cycles", 10, 0

    align 64
    aos_buf times 10000 dd 7, 0, 0, 0
    soa_buf times 10000 dd 7

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

    ; AoS
    rdtsc
    mov esi, eax

    mov edx, 500
.rep_aos:
    xor eax, eax
    xor ecx, ecx
.l_aos:
    add eax, [aos_buf + ecx*4]
    add ecx, 4
    cmp ecx, 40000
    jl .l_aos
    dec edx
    jnz .rep_aos

    rdtsc
    sub eax, esi
    mov edi, eax

    ; SoA
    rdtsc
    mov esi, eax

    mov edx, 500
.rep_soa:
    xor eax, eax
    xor ecx, ecx
.l_soa:
    add eax, [soa_buf + ecx*4]
    inc ecx
    cmp ecx, 10000
    jl .l_soa
    dec edx
    jnz .rep_soa

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
