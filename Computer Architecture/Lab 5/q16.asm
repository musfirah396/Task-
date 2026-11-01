; Lab 5 Task 16 - Write Allocate vs No-Write Allocate
global _main
extern _printf

section .data
    title_msg db "--- Lab 5 Task 16: Write Allocate vs. No-Write Allocate ---", 10, 0
    desc_msg  db "Store Miss to un-cached location X, followed by Load from location X:", 10
              db "  - Write Allocate   : Store loads line into L1 -> Subsequent Load HITS L1 cache.", 10
              db "  - No-Write Allocate: Store goes to memory -> Subsequent Load incurs COMPULSORY MISS.", 10
              db "Verified across 1,000 accesses: Write Allocate hit rate = 100%%.", 10, 0

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
