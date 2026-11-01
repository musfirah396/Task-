; Lab 6 Problem 6 - Power-of-Two Stride Degradation
global _main
extern _printf

section .data
    title_str db "--- Lab 6 Problem 6: Power-of-Two Stride Degradation ---", 10, 0
    desc_str  db "Direct-mapped cache: 128 bytes total, 16-byte block (8 sets).", 10
              db "Traversing 512-byte buffer with power-of-two strides:", 10
              db "  Stride  16 B (1 block)  : Uses 8 of 8 sets (100%% effective capacity)", 10
              db "  Stride  32 B (2 blocks) : Uses 4 of 8 sets ( 50%% effective capacity)", 10
              db "  Stride  64 B (4 blocks) : Uses 2 of 8 sets ( 25%% effective capacity)", 10
              db "  Stride 128 B (8 blocks) : Uses 1 of 8 sets (12.5%% capacity = 1 BLOCK!)", 10
              db "Conclusion: Harmonics matching cache size collapse capacity to 1 line.", 10, 0

    align 64
    buf_stride times 128 dd 1

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
