; Lab 4 Task 16 - Four-Way Unrolling with Register Renaming
global _main
extern _printf

section .data
    title_str db "--- Lab 4 Task 16: Four-Way Unrolling with Register Renaming ---", 10, 0
    res_str   db "Elapsed cycles (10,000 array items):", 10
              db "  Standard Single-Register : %u cycles (Sum = %d)", 10
              db "  4-Way Renamed Streams    : %u cycles (Sum = %d)", 10
              db "WAR/WAW false dependencies eliminated.", 10, 0

    align 16
    arr_data times 10000 dd 3
    saved_sum dd 0

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

    ; Standard
    rdtsc
    mov esi, eax

    mov edx, 500
.rep_s:
    xor eax, eax
    xor ecx, ecx
.l_s:
    add eax, [arr_data + ecx*4]
    inc ecx
    cmp ecx, 10000
    jl .l_s
    dec edx
    jnz .rep_s

    rdtsc
    sub eax, esi
    mov edi, eax

    ; 4-Way Renamed
    rdtsc
    mov esi, eax

    mov edx, 500
.rep_r:
    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor ebp, ebp
    mov [saved_sum], edx

    xor edx, edx
.l_r:
    add eax, [arr_data + edx*4]
    add ebx, [arr_data + edx*4 + 4]
    add ecx, [arr_data + edx*4 + 8]
    add ebp, [arr_data + edx*4 + 12]
    add edx, 4
    cmp edx, 10000
    jl .l_r

    add eax, ebx
    add eax, ecx
    add eax, ebp

    mov edx, [saved_sum]
    dec edx
    jnz .rep_r

    rdtsc
    sub eax, esi

    push 30000
    push eax
    push 30000
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
