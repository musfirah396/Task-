; Lab 4 Task 12 - Branch Elimination via Predication & Conditional Moves
global _main
extern _printf

section .data
    title_str db "--- Lab 4 Task 12: Branch Elimination via Predication ---", 10, 0
    res_str   db "Elapsed cycles (10,000 items):", 10
              db "  1. Branching abs()      : %u cycles", 10
              db "  2. Predicated CMOV abs(): %u cycles", 10
              db "  3. Branchless SAR+XOR   : %u cycles", 10
              db "Verification: abs(-75) = %d, abs(90) = %d", 10, 0

    align 16
    test_arr times 5000 dd 30, -30

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

    ; 1. Branching
    rdtsc
    mov esi, eax

    mov ecx, 10000
.l_br:
    mov eax, [test_arr + ecx*4 - 4]
    cmp eax, 0
    jge .skip_neg
    neg eax
.skip_neg:
    dec ecx
    jnz .l_br

    rdtsc
    sub eax, esi
    mov edi, eax

    ; 2. CMOV
    rdtsc
    mov esi, eax

    mov ecx, 10000
.l_cmov:
    mov eax, [test_arr + ecx*4 - 4]
    mov edx, eax
    neg edx
    test eax, eax
    cmovs eax, edx
    dec ecx
    jnz .l_cmov

    rdtsc
    sub eax, esi
    mov ebx, eax

    ; 3. Bitwise
    rdtsc
    mov esi, eax

    mov ecx, 10000
.l_bit:
    mov eax, [test_arr + ecx*4 - 4]
    mov edx, eax
    sar edx, 31
    xor eax, edx
    sub eax, edx
    dec ecx
    jnz .l_bit

    rdtsc
    sub eax, esi

    push 90
    push 75
    push eax
    push ebx
    push edi
    push res_str
    call _printf
    add esp, 24

    pop edi
    pop esi
    pop ebx
    xor eax, eax
    mov esp, ebp
    pop ebp
    ret
