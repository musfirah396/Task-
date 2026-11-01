; Lab 4 Task 7 - Interleaved Accumulators for RAW Reduction
global _main
extern _printf

section .data
    title_str db "--- Lab 4 Task 7: Loop-Carried Accumulation Dependencies ---", 10, 0
    desc_str  db "Single accumulator: serial RAW stalls on every loop step.", 10
              db "Dual accumulators (acc1, acc2): independent dependency chains expose ILP.", 10, 0
    bench_str db "Elapsed RDTSC - Single: %u cycles (Sum: %d) | Dual: %u cycles (Sum: %d)", 10, 0

    align 16
    vec_data times 1000 dd 4

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

    ; 1. Single accumulator
    rdtsc
    mov esi, eax

    mov edx, 1000
.rep_single:
    xor eax, eax
    xor ecx, ecx
.loop_single:
    add eax, [vec_data + ecx*4]
    inc ecx
    cmp ecx, 1000
    jl .loop_single
    dec edx
    jnz .rep_single

    rdtsc
    sub eax, esi
    mov edi, eax ; cycles single

    ; 2. Dual accumulators
    rdtsc
    mov esi, eax

    mov edx, 1000
.rep_dual:
    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
.loop_dual:
    add eax, [vec_data + ecx*4]
    add ebx, [vec_data + ecx*4 + 4]
    add ecx, 2
    cmp ecx, 1000
    jl .loop_dual
    add eax, ebx
    dec edx
    jnz .rep_dual

    rdtsc
    sub eax, esi ; cycles dual

    push 4000
    push eax
    push 4000
    push edi
    push bench_str
    call _printf
    add esp, 20

    pop edi
    pop esi
    pop ebx
    xor eax, eax
    mov esp, ebp
    pop ebp
    ret
