; Lab 4 Task 18 - Function Call Linkage Overhead
global _main
extern _printf

section .data
    title_str db "--- Lab 4 Task 18: Subroutine Call/Return Pipeline Overhead ---", 10, 0
    res_str   db "100,000 iterations:", 10
              db "  Inlined Loop Cycles    : %u cycles", 10
              db "  Call/Ret Loop Cycles   : %u cycles", 10
              db "  Overhead per Call/Ret  : ~%d cycles", 10, 0

section .text
helper_fn:
    add eax, 5
    ret

_main:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi

    push title_str
    call _printf
    add esp, 4

    ; Inlined
    rdtsc
    mov esi, eax

    xor eax, eax
    mov ecx, 100000
.l_inl:
    add eax, 5
    dec ecx
    jnz .l_inl

    rdtsc
    sub eax, esi
    mov edi, eax

    ; Subroutine
    rdtsc
    mov esi, eax

    xor eax, eax
    mov ecx, 100000
.l_call:
    call helper_fn
    dec ecx
    jnz .l_call

    rdtsc
    sub eax, esi
    mov ebx, eax

    ; Difference / 100000
    mov edx, ebx
    sub edx, edi
    mov eax, edx
    xor edx, edx
    mov ecx, 100000
    div ecx

    push eax
    push ebx
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
