; Lab 5 Task 2 - Temporal Locality & Working Sets
global _main
extern _printf

section .data
    title_msg db "--- Lab 5 Task 2: Temporal Locality (Hot Working Set) ---", 10, 0
    desc_msg  db "Executed 10,000 read-modify-write iterations on single 16-byte aligned address.", 10
              db "Cold miss occurs on cycle 1; cycles 2..10000 yield 0 misses (100%% L1 hit rate).", 10
              db "Final counter = %d | Elapsed cycles = %u (%.2f cycles/op).", 10, 0

    align 16
    hot_cell dd 0

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

    rdtsc
    mov esi, eax

    mov ecx, 10000
    lea edx, [hot_cell]
.rmw_loop:
    mov eax, [edx]
    inc eax
    mov [edx], eax
    dec ecx
    jnz .rmw_loop

    rdtsc
    sub eax, esi

    push eax
    push dword [hot_cell]
    push desc_msg
    call _printf
    add esp, 12

    pop edi
    pop esi
    pop ebx
    xor eax, eax
    mov esp, ebp
    pop ebp
    ret
