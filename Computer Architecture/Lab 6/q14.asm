; Lab 6 Problem 14 - FIFO Replacement Queue
global _main
extern _printf

section .data
    title_str db "--- Lab 6 Problem 14: First-In, First-Out (FIFO) Replacement Queue ---", 10, 0
    desc_str  db "Cyclic trace {A, B, C, D, E, A, B, C, D, E} on 4 slots:", 10
              db "  FIFO pointer updates: ptr = (ptr + 1) & 0x03 on miss.", 10
              db "  Hit count on cyclic sequence: 0 hits (10 misses - cyclic thrashing).", 10
              db "FIFO requires minimal hardware (1 pointer register, no comparators).", 10, 0

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
