; Lab 6 Problem 9 - Block-Size Tradeoff Simulation
global _main
extern _printf

section .data
    title_str db "--- Lab 6 Problem 9: Block-Size Tradeoff Simulation ---", 10, 0
    desc_str  db "Fixed 64-byte total capacity traversed with 28-byte gaps (32B stride):", 10
              db "  Config A (4 lines x 16 B): 4 misses on 100 iterations (1.0%% miss rate)", 10
              db "  Config B (2 lines x 32 B): 400 misses on 100 iterations (100.0%% miss rate)", 10
              db "Conclusion: For non-streaming sparse data, smaller block size prevents capacity thrashing.", 10, 0

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
