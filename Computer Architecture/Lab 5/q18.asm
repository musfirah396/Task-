; Lab 5 Task 18 - Cold-Start Latency Quantification
global _main
extern _printf

section .data
    title_msg db "--- Lab 5 Task 18: Cache Flushing & Cold-Start Latency Quantification ---", 10, 0
    desc_msg  db "Hardware RDTSC timing with CLFLUSH:", 10
              db "  Hot L1 Hit Latency  : %u cycles", 10
              db "  Cold Miss (CLFLUSH) : %u cycles", 10
              db "  DRAM penalty ratio  : %u : 1", 10, 0

    align 64
    fl_cell dd 88
    times 15 dd 0

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

    mov eax, [fl_cell] ; warm up

    ; Hot
    rdtsc
    mov esi, eax
    mov ebx, [fl_cell]
    rdtsc
    sub eax, esi
    mov edi, eax

    ; Flush
    clflush [fl_cell]
    mfence

    rdtsc
    mov esi, eax
    mov ebx, [fl_cell]
    rdtsc
    sub eax, esi
    mov ebx, eax

    ; Ratio
    mov eax, ebx
    xor edx, edx
    mov ecx, edi
    cmp ecx, 0
    jne .ok_d
    mov ecx, 1
.ok_d:
    div ecx

    push eax
    push ebx
    push edi
    push desc_msg
    call _printf
    add esp, 16

    pop edi
    pop esi
    pop ebx
    xor eax, eax
    mov esp, ebp
    pop ebp
    ret
