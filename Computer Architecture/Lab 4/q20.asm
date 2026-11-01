; Lab 4 Task 20 - Self-Modifying Code Coherency Hazard
global _main
extern _printf

section .data
    title_str db "--- Lab 4 Task 20: Instruction-Cache Synchronization Hazards ---", 10, 0
    res_str   db "Dynamically mutated opcode from NOP to INC EAX.", 10
              db "Initial=%d, Result after patch execution=%d", 10
              db "SMC penalty: %u cycles (enforced pipeline snoop flush).", 10, 0

    init_val dd 20
    final_v  dd 0

align 16
patch_target:
    push ebp
    mov ebp, esp
    mov eax, [ebp + 8]
patch_point:
    nop
    nop
    mov esp, ebp
    pop ebp
    ret

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

    rdtsc
    mov esi, eax

    ; Patch NOPs (0x90) to INC EAX (0x40)
    mov byte [patch_point], 0x40
    mov byte [patch_point + 1], 0x40

    push dword [init_val]
    call patch_target
    add esp, 4
    mov [final_v], eax

    rdtsc
    sub eax, esi

    push eax
    push dword [final_v]
    push dword [init_val]
    push res_str
    call _printf
    add esp, 16

    pop edi
    pop esi
    pop ebx
    xor eax, eax
    mov esp, ebp
    pop ebp
    ret
