; Lab 4 Task 3 - Writeback Port Contention
global _main
extern _printf

section .data
    title_str db "--- Lab 4 Task 3: Register File Write-Port Contention ---", 10, 0
    desc_str  db "Analysis: Multicycle MULT (4-cycle latency) and single-cycle ADD", 10
              db "both schedule writeback (WB) for Cycle 7.", 10
              db "Arbiter grants write port to MULT; ADD is stalled in EX/WB register by 1 cycle.", 10, 0
    res_str   db "Executed: MULT (16 * 30) = %d | ADD (45 + 55) = %d | Conflict resolved.", 10, 0

    res_m dd 0
    res_a dd 0

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

    ; Simulate calculations
    mov eax, 16
    mov ecx, 30
    imul eax, ecx
    mov [res_m], eax

    mov edx, 45
    add edx, 55
    mov [res_a], edx

    push dword [res_a]
    push dword [res_m]
    push res_str
    call _printf
    add esp, 12

    pop edi
    pop esi
    pop ebx
    xor eax, eax
    mov esp, ebp
    pop ebp
    ret
