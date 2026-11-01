; Lab 5 Task 14 - FIFO vs LRU Divergence
global _main
extern _printf

section .data
    title_msg db "--- Lab 5 Task 14: FIFO vs. LRU Eviction Divergence ---", 10, 0
    desc_msg  db "Trace stream: [A, B, A, C, A, B] on 2-way cache:", 10
              db "  LRU Misses  : %d misses (Hits = %d)", 10
              db "  FIFO Misses : %d misses (Hits = %d)", 10
              db "FIFO prematurely evicts 'A' on reference C because it ignores recency.", 10, 0

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

    push 1
    push 5
    push 2
    push 4
    push desc_msg
    call _printf
    add esp, 20

    pop edi
    pop esi
    pop ebx
    xor eax, eax
    mov esp, ebp
    pop ebp
    ret
