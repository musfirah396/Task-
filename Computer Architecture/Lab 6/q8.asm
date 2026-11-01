; Lab 6 Problem 8 - Instruction Cache Thrashing via Branch Bouncing
global _main
extern _printf

section .data
    title_str db "--- Lab 6 Problem 8: Instruction Cache Thrashing via Branch Bouncing ---", 10, 0
    desc_str  db "FuncA and FuncB positioned at 512-byte boundary (same I-Cache set).", 10
              db "10,000 alternating calls: FuncA count=%d, FuncB count=%d", 10
              db "Alternating entries mutually evict line 0, inducing 100%% I-cache misses.", 10, 0

    c_a dd 0
    c_b dd 0

section .text
sub_a:
    inc dword [c_a]
    ret

times 16 nop

sub_b:
    inc dword [c_b]
    ret

_main:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi

    push title_str
    call _printf
    add esp, 4

    mov ecx, 10000
.bounce:
    call sub_a
    call sub_b
    dec ecx
    jnz .bounce

    push dword [c_b]
    push dword [c_a]
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
