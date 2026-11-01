; Lab 4 Task 10 - Taken vs Not-Taken Branch Penalties
global _main
extern _printf

section .data
    title_str db "--- Lab 4 Task 10: Quantifying Taken vs. Not-Taken Branch Penalties ---", 10, 0
    desc_str  db "Static branch assumption predicts forward branches as Not-Taken.", 10
              db "Evaluating 1,000 iterations for 95%% Taken vs 95%% Not-Taken...", 10, 0
    res_str   db "  95%% Taken loop     : %u cycles", 10
              db "  95%% Not-Taken loop : %u cycles", 10
              db "  Flush overhead delta: %d cycles", 10, 0

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

    ; 95% Taken
    rdtsc
    mov esi, eax

    mov ecx, 1000
.l_taken:
    mov eax, ecx
    and eax, 15
    cmp eax, 0
    jne .jump_target
    nop
.jump_target:
    dec ecx
    jnz .l_taken

    rdtsc
    sub eax, esi
    mov edi, eax ; cycles taken

    ; 95% Not-Taken
    rdtsc
    mov esi, eax

    mov ecx, 1000
.l_ntaken:
    mov eax, ecx
    and eax, 15
    cmp eax, 0
    je .rare_jump
    nop
    jmp .continue_nt
.rare_jump:
    nop
.continue_nt:
    dec ecx
    jnz .l_ntaken

    rdtsc
    sub eax, esi ; cycles not taken

    mov edx, edi
    sub edx, eax

    push edx
    push eax
    push edi
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
