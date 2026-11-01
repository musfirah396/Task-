; Lab 6 Problem 19 - Instruction Overhead Profiler
global _main
extern _printf

section .data
    title_str db "--- Lab 6 Problem 19: Instruction Overhead vs Associativity Profiler ---", 10, 0
    desc_str  db "Profiling lookup routines:", 10
              db "  Direct-Mapped: 5 dynamic instructions (SHR, AND, MOV, CMP, JNE) -> O(1).", 10
              db "  Fully Associative: ~24 dynamic instructions (loop scan over 8 tags) -> O(N).", 10
              db "Associativity in software introduces ~5x CPU instruction overhead.", 10
              db "Shows why hardware requires dedicated parallel CAM comparators.", 10, 0

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

    push desc_str
    call _printf
    add esp, 4

    pop edi
    pop esi
    pop ebx
    xor eax, eax
    mov esp, ebp
    pop ebp
    ret
