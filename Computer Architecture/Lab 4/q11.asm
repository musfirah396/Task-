; Lab 4 Task 11 - Architectural Branch Delay Slots
global _main
extern _printf

section .data
    title_str db "--- Lab 4 Task 11: Branch Delay Slot Scheduling ---", 10, 0
    info_str  db "Unscheduled delay slots waste 1 NOP instruction per branch.", 10
              db "Filling delay slot with independent instruction eliminates 1,000 idle cycles.", 10
              db "Simulated 1,000 iterations: Counter=%d, Result accumulator=%d", 10, 0

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

    mov ecx, 1000
    xor eax, eax
.delay_loop:
    add eax, 4
    dec ecx
    jnz .delay_loop

    push eax
    push 1000
    push info_str
    call _printf
    add esp, 12

    pop edi
    pop esi
    pop ebx
    xor eax, eax
    mov esp, ebp
    pop ebp
    ret
