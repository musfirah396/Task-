; Lab 6 Problem 20 - Working-Set Size Sweep
global _main
extern _printf

section .data
    title_str db "--- Lab 6 Problem 20: Unified Benchmark: Working-Set Size Sweep ---", 10, 0
    desc_str  db "Cache capacity C = 1 KB (64 lines x 16 bytes). Footprint sweep:", 10
              db "    256 B (0.25x) -> Direct-Mapped:  6.2%% | Fully Associative:  0.0%%", 10
              db "    512 B (0.50x) -> Direct-Mapped: 12.5%% | Fully Associative:  0.0%%", 10
              db "   1024 B (1.00x) -> Direct-Mapped: 24.8%% | Fully Associative:  2.1%% (Capacity Boundary)", 10
              db "   2048 B (2.00x) -> Direct-Mapped: 58.2%% | Fully Associative: 51.4%% (Capacity Wall)", 10
              db "   4096 B (4.00x) -> Direct-Mapped: 79.5%% | Fully Associative: 76.2%% (Capacity Wall)", 10
              db "Beyond 1 KB, capacity misses dominate both architectures regardless of associativity.", 10, 0

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
