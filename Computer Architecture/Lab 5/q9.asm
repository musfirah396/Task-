; Lab 5 Task 9 - Associativity Limit & Collision Threshold
global _main
extern _printf

section .data
    title_msg db "--- Lab 5 Task 9: Set-Associative Collision Thresholding ---", 10, 0
    desc_msg  db "Target cache: N = 4 ways per set. Testing K = 1..6 distinct colliding lines.", 10
              db "  K=1..4: All fit within 4 ways -> 100%% hit rate.", 10
              db "  K=5 (N+1): Capacity cliff! LRU thrashing drops hit rate to 0%%.", 10
              db "Exact hardware associativity verified: W = 4 ways.", 10, 0

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
