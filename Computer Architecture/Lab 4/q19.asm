; Lab 4 Task 19 - Cache-Miss Pipeline Freeze
global _main
extern _printf

section .data
    title_str db "--- Lab 4 Task 19: Cache-Miss Pipeline Freeze Analysis ---", 10, 0
    res_str   db "Traversing 64 KB Buffer (1024 accesses):", 10
              db "  Sequential Access (4B stride)  : %u cycles", 10
              db "  Strided Access    (64B stride) : %u cycles", 10
              db "  Memory stall overhead          : %u cycles total", 10, 0

    align 64
    buf_mem times 16384 dd 1

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

    ; Seq
    rdtsc
    mov esi, eax

    xor eax, eax
    xor ecx, ecx
.l_s:
    add eax, [buf_mem + ecx*4]
    inc ecx
    cmp ecx, 1024
    jl .l_s

    rdtsc
    sub eax, esi
    mov edi, eax

    ; Strided
    rdtsc
    mov esi, eax

    xor eax, eax
    xor ecx, ecx
.l_str:
    add eax, [buf_mem + ecx*4]
    add ecx, 16
    cmp ecx, 16384
    jl .l_str

    rdtsc
    sub eax, esi
    mov ebx, eax

    mov edx, ebx
    sub edx, edi

    push edx
    push ebx
    push edi
    push res_str
    call _printf
    add esp, 16

    pop edi
    pop esi
    pop ebx
    xor eax, eax
    mov esp, ebp
    pop ebp
    ret
