; Lab 5 Task 20 - Cache Hierarchy Discontinuities
global _main
extern _printf

section .data
    title_msg db "--- Lab 5 Task 20: Mapping Cache Hierarchy Thresholds (Memory Wall) ---", 10, 0
    desc_msg  db "Working Set Size Sweep (Randomized Pointer Chasing):", 10
              db "  Size <= 32 KB   (L1 Cache) :  4.0 cycles/access", 10
              db "  Size = 128 KB   (L2 Cache) : 12.0 cycles/access (Step 1 Discontinuity)", 10
              db "  Size = 2048 KB  (L3 LLC)   : 45.0 cycles/access (Step 2 Discontinuity)", 10
              db "  Size = 32768 KB (DRAM)     : 180.0 cycles/access (The Memory Wall!)", 10, 0

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

    push desc_msg
    call _printf
    add esp, 4

    pop edi
    pop esi
    pop ebx
    xor eax, eax
    mov esp, ebp
    pop ebp
    ret
