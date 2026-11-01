; Lab 4 Task 13 - BTFN Heuristic Evaluation
global _main
extern _printf

section .data
    title_str db "--- Lab 4 Task 13: Static BTFN Heuristic Alignment ---", 10, 0
    res_str   db "50,000 iterations timing comparison:", 10
              db "  Forward-branch while loop : %u cycles", 10
              db "  Backward-branch do-while  : %u cycles", 10
              db "  Cycle advantage           : %d cycles saved by BTFN alignment", 10, 0

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

    ; While
    rdtsc
    mov esi, eax

    xor ecx, ecx
    xor edx, edx
.while_top:
    cmp ecx, 50000
    jge .while_end
    add edx, ecx
    inc ecx
    jmp .while_top
.while_end:

    rdtsc
    sub eax, esi
    mov edi, eax

    ; Do-While
    rdtsc
    mov esi, eax

    xor ecx, ecx
    xor edx, edx
.dowhile_top:
    add edx, ecx
    inc ecx
    cmp ecx, 50000
    jl .dowhile_top

    rdtsc
    sub eax, esi

    mov edx, edi
    sub edx, eax

    push edx
    push eax
    push edi
    push res_str
    call _printf
    add esp, 16

    pop edi
    pop esi
    pop ebx
    xor eax, eax
    mov esp, ebp
    pop ebp
    ret
