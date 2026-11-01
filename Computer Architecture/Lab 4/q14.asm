; Lab 4 Task 14 - Dynamic 2-Bit Predictor Thrashing
global _main
extern _printf

section .data
    title_str db "--- Lab 4 Task 14: Dynamic 2-Bit BHT Predictor Thrashing ---", 10, 0
    p1_str    db "Homogeneous pattern (100 Taken)  : %d misprediction (99%% accuracy)", 10, 0
    p2_str    db "Alternating pattern (T, NT, T...): %d mispredictions (0%% accuracy - Thrashing!)", 10, 0

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

    ; Homogeneous
    mov bl, 0
    xor esi, esi
    mov ecx, 100
.l_homo:
    mov al, bl
    shr al, 1
    cmp al, 1
    je .ok_h
    inc esi
.ok_h:
    cmp bl, 3
    jge .cap_h
    inc bl
.cap_h:
    dec ecx
    jnz .l_homo

    push esi
    push p1_str
    call _printf
    add esp, 8

    ; Alternating
    mov bl, 0
    xor edi, edi
    mov ecx, 100
    xor edx, edx
.l_alt:
    xor edx, 1
    mov al, bl
    shr al, 1
    cmp al, dl
    je .ok_a
    inc edi
.ok_a:
    cmp edx, 1
    jne .nt_a
    cmp bl, 3
    jge .done_a
    inc bl
    jmp .done_a
.nt_a:
    cmp bl, 0
    jle .done_a
    dec bl
.done_a:
    dec ecx
    jnz .l_alt

    push edi
    push p2_str
    call _printf
    add esp, 8

    pop edi
    pop esi
    pop ebx
    xor eax, eax
    mov esp, ebp
    pop ebp
    ret
