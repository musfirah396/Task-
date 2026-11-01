; Lab 5 Task 5 - Loop Tiling (Blocking)
global _main
extern _printf

section .data
    title_msg db "--- Lab 5 Task 5: Loop Tiling (Blocking) for Spatial & Temporal Reuse ---", 10, 0
    desc_msg  db "Condition: 2 * T^2 * sizeof(element) <= Cache_Capacity", 10
              db "For 32 KB L1: 8 * T^2 <= 32768 -> Max theoretical T = 64; practical T = 16.", 10
              db "Transposition timing (64x64): Naive = %u cycles | Tiled (T=16) = %u cycles", 10
              db "Sample verification: A[2][5]=%d -> B[5][2]=%d", 10, 0

    align 64
    matA times 4096 dd 0
    matB times 4096 dd 0

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

    ; Init
    xor ecx, ecx
.init_m:
    mov [matA + ecx*4], ecx
    inc ecx
    cmp ecx, 4096
    jl .init_m

    ; Naive
    rdtsc
    mov esi, eax

    xor ecx, ecx
.n_i:
    xor edx, edx
.n_j:
    mov eax, ecx
    shl eax, 6
    add eax, edx
    mov ebx, [matA + eax*4]

    mov eax, edx
    shl eax, 6
    add eax, ecx
    mov [matB + eax*4], ebx
    inc edx
    cmp edx, 64
    jl .n_j
    inc ecx
    cmp ecx, 64
    jl .n_i

    rdtsc
    sub eax, esi
    mov edi, eax ; cycles naive

    ; Tiled (T = 16)
    rdtsc
    mov esi, eax

    xor ecx, ecx
.t_ii:
    xor edx, edx
.t_jj:
    xor eax, eax
.t_di:
    xor ebx, ebx
.t_dj:
    lea esi, [ecx + eax]
    lea ebp, [edx + ebx]

    push ecx
    mov ecx, esi
    shl ecx, 6
    add ecx, ebp
    mov ecx, [matA + ecx*4]

    push edx
    mov edx, ebp
    shl edx, 6
    add edx, esi
    mov [matB + edx*4], ecx
    pop edx
    pop ecx

    inc ebx
    cmp ebx, 16
    jl .t_dj
    inc eax
    cmp eax, 16
    jl .t_di

    add edx, 16
    cmp edx, 64
    jl .t_jj
    add ecx, 16
    cmp ecx, 64
    jl .t_ii

    rdtsc
    sub eax, esi ; cycles tiled

    ; A[2][5] is 2*64+5 = 133; B[5][2] is 5*64+2 = 322
    push dword [matB + 322*4]
    push dword [matA + 133*4]
    push eax
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
