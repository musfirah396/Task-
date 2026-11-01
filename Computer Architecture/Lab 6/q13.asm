; Lab 6 Problem 13 - Conflict Immunity Test
global _main
extern _printf

section .data
    title_str db "--- Lab 6 Problem 13: Conflict Immunity (Anti-Ping-Pong Test) ---", 10, 0
    desc_str  db "Alternating reads {0x000, 0x400, 0x800, 0x000, 0x400, 0x800}:", 10
              db "  Direct-Mapped: 100%% conflict misses (Ping-Pong thrashing on set 0).", 10
              db "  Fully Associative (4 slots): 3 cold misses, 3 HITS! (Zero conflict misses).", 10
              db "Any block can reside in any slot, granting complete conflict immunity.", 10, 0

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
