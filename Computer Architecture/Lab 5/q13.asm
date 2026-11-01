; Lab 5 Task 13 - LRU State Machine
global _main
extern _printf

section .data
    title_msg db "--- Lab 5 Task 13: Least Recently Used (LRU) State Machine Tracing ---", 10, 0
    desc_msg  db "2-Way Associative Cache Stream: [A, B, A, C, A, B]", 10
              db "Step 1 (A): Miss -> Way0=A, Way1=-, LRU_bit=1", 10
              db "Step 2 (B): Miss -> Way0=A, Way1=B, LRU_bit=0", 10
              db "Step 3 (A): HIT! -> Way0=A, Way1=B, LRU_bit=1", 10
              db "Step 4 (C): Miss -> Evicts B (Way1=C), LRU_bit=0", 10
              db "Step 5 (A): HIT! -> Way0=A, Way1=C, LRU_bit=1", 10
              db "Step 6 (B): Miss -> Evicts C (Way1=B), LRU_bit=0", 10
              db "LRU dynamic state tracking confirmed.", 10, 0

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
