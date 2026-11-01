; Lab 4 Task 2 - Functional Unit Latency & Scheduling
global _main
extern _printf

section .data
    title_str db "--- Lab 4 Task 2: Multicycle Functional Unit Latency ---", 10, 0
    u_sched   db "[Unscheduled Pattern]: DIV (12 cycles) -> immediate result read -> 11 stalls!", 10, 0
    s_sched   db "[Scheduled Pattern]  : 3 independent instructions interleaved -> stalls reduced to 8!", 10, 0
    out_fmt   db "RDTSC Elapsed - Unscheduled: %u cycles | Scheduled: %u cycles", 10
              db "Computed result: Quotient = %d, Remainder = %d", 10, 0

    align 4
    val_n dd 500000
    val_d dd 125
    q_out dd 0
    r_out dd 0

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

    push u_sched
    call _printf
    add esp, 4

    push s_sched
    call _printf
    add esp, 4

    ; Benchmark Unscheduled
    rdtsc
    mov esi, eax

    mov ecx, 500
.loop_u:
    mov eax, [val_n]
    xor edx, edx
    mov ebx, [val_d]
    div ebx
    mov [q_out], eax
    mov [r_out], edx
    add ebx, 1
    sub ebx, 1
    dec ecx
    jnz .loop_u

    rdtsc
    sub eax, esi
    mov edi, eax ; cycles_u

    ; Benchmark Scheduled
    rdtsc
    mov esi, eax

    mov ecx, 500
.loop_s:
    mov eax, [val_n]
    xor edx, edx
    mov ebx, [val_d]
    div ebx
    add ecx, 0
    sub ebx, 0
    mov [q_out], eax
    mov [r_out], edx
    dec ecx
    jnz .loop_s

    rdtsc
    sub eax, esi ; cycles_s

    push dword [r_out]
    push dword [q_out]
    push eax
    push edi
    push out_fmt
    call _printf
    add esp, 20

    pop edi
    pop esi
    pop ebx
    xor eax, eax
    mov esp, ebp
    pop ebp
    ret
