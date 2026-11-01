; Lab 6 Problem 11 - Linear Tag Comparison Engine
global _main
extern _printf

section .data
    title_str db "--- Lab 6 Problem 11: Tag Comparison Engine (Linear Search) ---", 10, 0
    desc_str  db "Fully associative cache (8 lines, 16 B/line, Tag=bits [31:4]):", 10
              db "  Linear sequential scan evaluated: Address 0x%X -> %s in %d steps", 10
              db "Contrasts O(1) single-cycle direct-mapped indexing with O(N) software search.", 10, 0

    hit_txt   db "HIT", 0
    miss_txt  db "MISS", 0

    align 16
    tags8 dd 0x100, 0x200, 0x300, 0x400, 0x500, 0x600, 0x700, 0x800

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

    ; Search for 0x3000 (Tag 0x300)
    mov eax, 0x3000
    shr eax, 4          ; tag = 0x300
    xor ecx, ecx
.scan:
    inc ecx
    cmp eax, [tags8 + ecx*4 - 4]
    je .found
    cmp ecx, 8
    jl .scan
    lea edi, [miss_txt]
    jmp .disp
.found:
    lea edi, [hit_txt]

.disp:
    push ecx
    push edi
    push 0x3000
    push desc_str
    call _printf
    add esp, 16

    pop edi
    pop esi
    pop ebx
    xor eax, eax
    mov esp, ebp
    pop ebp
    ret
