; Lab 4 Task 4 - NOP Insertion for RAW Hazard Resolution
global _main
extern _printf

section .data
    title_str db "--- Lab 4 Task 4: Software NOP Hazard Resolution ---", 10, 0
    theory_str db "Pipeline rules without forwarding:", 10
               db "  Producer writes to register in first half of WB (Cycle 5).", 10
               db "  Consumer reads in ID stage. Minimum 2 NOPs required to avoid stale data.", 10, 0
    res_str    db "  Initial R1=%d, R2=%d, R3=%d, R5=%d", 10
               db "  Stale read (0 NOPs) : R4 = stale_R1 + R5 = %d", 10
               db "  Correct read (2 NOPs): R4 = updated_R1 + R5 = %d", 10, 0

    r1_old dd 8
    r2_val dd 15
    r3_val dd 25
    r5_val dd 6

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

    push theory_str
    call _printf
    add esp, 4

    ; Updated R1 = R2 + R3 = 40
    mov eax, [r2_val]
    add eax, [r3_val] ; eax = 40

    ; Stale calculation
    mov ebx, [r1_old]
    add ebx, [r5_val] ; 8 + 6 = 14

    ; Correct calculation (with 2 NOPs)
    nop
    nop
    mov edx, eax
    add edx, [r5_val] ; 40 + 6 = 46

    push edx
    push ebx
    push dword [r5_val]
    push dword [r3_val]
    push dword [r2_val]
    push dword [r1_old]
    push res_str
    call _printf
    add esp, 28

    pop edi
    pop esi
    pop ebx
    xor eax, eax
    mov esp, ebp
    pop ebp
    ret
