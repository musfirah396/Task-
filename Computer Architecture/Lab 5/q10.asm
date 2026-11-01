; Lab 5 Task 10 - CAM Emulation
global _main
extern _printf

section .data
    title_msg db "--- Lab 5 Task 10: Fully Associative CAM Software Emulation ---", 10, 0
    res1_msg  db "Lookup Tag 0x%X -> Cache HIT  in Entry %d", 10, 0
    res2_msg  db "Lookup Tag 0x%X -> Cache MISS in Entry %d (Allocated)", 10, 0

    align 16
    cam_v db 1, 1, 1, 0, 0, 0, 0, 0
    align 4
    cam_t dd 0x11, 0x22, 0x33, 0, 0, 0, 0, 0

section .text
cam_find:
    xor ecx, ecx
.s_loop:
    movzx edx, byte [cam_v + ecx]
    test edx, edx
    jz .skip
    cmp eax, [cam_t + ecx*4]
    je .match
.skip:
    inc ecx
    cmp ecx, 8
    jl .s_loop

    ; miss
    xor edx, edx
    mov ecx, 3
    mov byte [cam_v + 3], 1
    mov [cam_t + 3*4], eax
    ret
.match:
    mov edx, 1
    ret

_main:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi

    push title_msg
    call _printf
    add esp, 4

    ; Hit
    mov eax, 0x22
    call cam_find
    push ecx
    push 0x22
    push res1_msg
    call _printf
    add esp, 12

    ; Miss
    mov eax, 0x99
    call cam_find
    push ecx
    push 0x99
    push res2_msg
    call _printf
    add esp, 12

    pop edi
    pop esi
    pop ebx
    xor eax, eax
    mov esp, ebp
    pop ebp
    ret
