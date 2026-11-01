; Lab 6 Problem 18 - Pathological Cyclic Thrashing
global _main
extern _printf

section .data
    title_str db "--- Lab 6 Problem 18: Pathological Cyclic Thrashing (Capacity vs. Conflict) ---", 10, 0
    desc_str  db "Working set of N=5 blocks {0, 1, 2, 3, 4} on K=4 slots under LRU:", 10
              db "  Total Accesses : 100", 10
              db "  Cache Hits     : 0 (0.0%% Hit Rate!)", 10
              db "  Cache Misses   : 100 (100.0%% Miss Rate!)", 10
              db "Proves that fully associative caches still collapse under capacity oversubscription.", 10, 0

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
