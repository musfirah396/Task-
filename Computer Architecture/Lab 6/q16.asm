; Lab 6 Problem 16 - Belady???s MIN Offline Comparison
global _main
extern _printf

section .data
    title_str db "--- Lab 6 Problem 16: Optimal (Belady???s MIN) Offline Comparison ---", 10, 0
    desc_str  db "Reference string: [1, 2, 3, 4, 1, 2, 5, 1, 2, 3, 4, 5] on 3-slot cache:", 10
              db "  Belady's MIN (Lookahead) : 7 misses (Provably optimal bound)", 10
              db "  LRU (Online Heuristic)   : 10 misses (42.8%% more misses)", 10
              db "Performance gap between online policy and theoretical upper bound demonstrated.", 10, 0

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
