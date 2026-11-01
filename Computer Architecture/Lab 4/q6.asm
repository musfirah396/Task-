; Lab 4 Task 6 - Static Code Rescheduling
global _main
extern _printf

section .data
    title_str db "--- Lab 4 Task 6: Software Instruction Rescheduling ---", 10, 0
    orig_str  db "Original sequence: 2 load-use stalls (10 cycles total, CPI = 2.50)", 10, 0
    reord_str db "Rescheduled: LW t0; LW t3; ADD t1, t0; SUB t4, t3; -> 0 stalls (8 cycles total)!", 10, 0
    verif_str db "Verified output states: t1 = %d, t4 = %d", 10, 0

    mem_pair  dd 60, 140
    reg_t2    dd 25
    reg_t5    dd 40

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

    push orig_str
    call _printf
    add esp, 4

    push reord_str
    call _printf
    add esp, 4

    ; Rescheduled execution
    lea esi, [mem_pair]
    mov eax, [esi]       ; lw t0
    mov ebx, [esi + 4]   ; lw t3 (fills load delay)
    add eax, [reg_t2]    ; add t1, t0, t2
    sub ebx, [reg_t5]    ; sub t4, t3, t5

    push ebx
    push eax
    push verif_str
    call _printf
    add esp, 12

    pop edi
    pop esi
    pop ebx
    xor eax, eax
    mov esp, ebp
    pop ebp
    ret
