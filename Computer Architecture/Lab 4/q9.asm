; Lab 4 Task 9 - Forwarding Multiplexer Routing
global _main
extern _printf

section .data
    title_str db "--- Lab 4 Task 9: Distance-1 vs Distance-2 Forwarding Paths ---", 10, 0
    d1_str    db "Distance 1 (Adjacent instructions): Producer in EX/MEM -> ForwardA = 10", 10, 0
    d2_str    db "Distance 2 (1 instruction apart)  : Producer in MEM/WB -> ForwardA = 01", 10, 0
    res_str   db "Calculation checks: Input1=%d, Input2=%d -> Prod=%d, Cons=%d", 10, 0

    val1 dd 33
    val2 dd 67
    subv dd 15

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

    push d1_str
    call _printf
    add esp, 4

    push d2_str
    call _printf
    add esp, 4

    mov eax, [val1]
    add eax, [val2] ; producer
    mov ebx, eax
    sub eax, [subv] ; consumer

    push eax
    push ebx
    push dword [val2]
    push dword [val1]
    push res_str
    call _printf
    add esp, 20

    pop edi
    pop esi
    pop ebx
    xor eax, eax
    mov esp, ebp
    pop ebp
    ret
