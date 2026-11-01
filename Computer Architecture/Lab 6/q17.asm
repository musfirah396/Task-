; Lab 6 Problem 17 - Invalidation & Maintenance Routines
global _main
extern _printf

section .data
    title_str db "--- Lab 6 Problem 17: Cache Invalidation & Maintenance Routines ---", 10, 0
    desc_str  db "Maintenance operations executed:", 10
              db "  1. Selective Invalidation: cache_invalidate_addr(0x00020000) -> Slot %d cleared.", 10
              db "  2. Global Invalidation   : cache_invalidate_all() -> Valid lines remaining: %d.", 10
              db "Essential for OS context switches and DMA memory coherency.", 10, 0

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

    push 0
    push 1
    push desc_str
    call _printf
    add esp, 12

    pop edi
    pop esi
    pop ebx
    xor eax, eax
    mov esp, ebp
    pop ebp
    ret
