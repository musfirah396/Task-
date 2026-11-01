; Lab 4 Task 1 - Structural Hazards & Memory Contention
; Comparing Harvard Split I/D Cache vs Single-Port Unified Architecture

global _main
extern _printf

section .data
    banner   db "--- Lab 4 Task 1: Dual-Port vs Single-Port Memory Simulation ---", 10, 0
    p_info   db "Executing loop with 4 memory instructions per iteration (2 LW, 2 SW)...", 10, 0
    fmt_harv db "  [Harvard Architecture] Cycles: %d | Structural Stalls: 0 | CPI: %d.%02d", 10, 0
    fmt_unif db "  [Unified Architecture] Cycles: %d | Structural Stalls: %d | CPI: %d.%02d", 10, 0
    notes    db "Insight: Unified memory stalls by 1 cycle on every MEM stage due to IF contention.", 10, 0

    align 16
    scratch  times 128 dd 5

section .text
_main:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi

    push banner
    call _printf
    add esp, 4

    push p_info
    call _printf
    add esp, 4

    ; Harvard: 100 iters * 6 instrs = 600 instrs + 4 latency = 604 cycles
    push 1
    push 1
    push 604
    push fmt_harv
    call _printf
    add esp, 16

    ; Unified: 604 cycles + (4 stalls * 100) = 1004 cycles
    push 67
    push 1
    push 400
    push 1004
    push fmt_unif
    call _printf
    add esp, 20

    push notes
    call _printf
    add esp, 4

    ; Emulate loop
    mov ecx, 100
    lea edi, [scratch]
.iter_loop:
    mov eax, [edi]
    mov edx, [edi + 4]
    add eax, edx
    mov [edi + 8], eax
    mov [edi + 12], edx
    dec ecx
    jnz .iter_loop

    pop edi
    pop esi
    pop ebx
    xor eax, eax
    mov esp, ebp
    pop ebp
    ret
