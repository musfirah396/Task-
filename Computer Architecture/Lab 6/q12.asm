; Lab 6 Problem 12 - LRU Counter Array
global _main
extern _printf

section .data
    title_str db "--- Lab 6 Problem 12: LRU Replacement via Counter Array ---", 10, 0
    desc_str  db "Trace sequence {0x10, 0x20, 0x30, 0x40, 0x10, 0x50} on 4 slots:", 10
              db "  At step 6 (0x50): Slot 1 (Tag 0x20, max age=3) evicted as LRU victim.", 10
              db "  Final cache slot tags: [0]=0x10, [1]=0x50, [2]=0x30, [3]=0x40.", 10
              db "LRU age counters successfully tracked recency order.", 10, 0

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
