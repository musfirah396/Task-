; Lab 4 Task 5 - Load-Use Forwarding Penalty
global _main
extern _printf

section .data
    title_str db "--- Lab 4 Task 5: Exposing the Load-Use Forwarding Penalty ---", 10, 0
    body_str  db "Analysis: LW loads data into MEM/WB at end of Cycle 4.", 10
              db "ADD requires operand at start of Cycle 3. Data cannot travel back in time.", 10
              db "Hardware Hazard Unit must insert 1 bubble stall cycle even with bypassing.", 10
              db "Sample execution: Loaded word = %d, Operand = %d, Result = %d", 10, 0

    mem_cell dd 150
    op_val   dd 45
    res_val  dd 0

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

    ; Load-use dependency
    mov eax, [mem_cell] ; lw
    add eax, [op_val]   ; add dependent on eax
    mov [res_val], eax

    push dword [res_val]
    push dword [op_val]
    push dword [mem_cell]
    push body_str
    call _printf
    add esp, 16

    pop edi
    pop esi
    pop ebx
    xor eax, eax
    mov esp, ebp
    pop ebp
    ret
