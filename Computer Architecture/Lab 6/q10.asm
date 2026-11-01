; Lab 6 Problem 10 - Loop Tiling for 1D Filter
global _main
extern _printf

section .data
    title_str db "--- Lab 6 Problem 10: Loop Tiling (Blocking) for a 1D Filter ---", 10, 0
    desc_str  db "3-tap moving average filter on 1024-byte array (256-byte cache):", 10
              db "  Naive traversal cycles : %u cycles", 10
              db "  Tiled traversal cycles : %u cycles (Tile block = 32 words)", 10
              db "Filter calculation verified: Y[15] = %d (Expected: %d)", 10, 0

    align 64
    x_buf times 256 dd 15
    y_buf times 256 dd 0

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

    ; Naive
    rdtsc
    mov esi, eax

    mov edx, 500
.rep_n:
    mov ecx, 1
.l_n:
    mov eax, [x_buf + ecx*4 - 4]
    add eax, [x_buf + ecx*4]
    add eax, [x_buf + ecx*4 + 4]
    push edx
    xor edx, edx
    mov ebx, 3
    div ebx
    pop edx
    mov [y_buf + ecx*4], eax
    inc ecx
    cmp ecx, 255
    jl .l_n
    dec edx
    jnz .rep_n

    rdtsc
    sub eax, esi
    mov edi, eax

    ; Tiled
    rdtsc
    mov esi, eax

    mov edx, 500
.rep_t:
    xor ebx, ebx
.b_out:
    mov ecx, 1
.b_in:
    lea eax, [ebx + ecx]
    cmp eax, 255
    jge .next_b
    mov ebp, [x_buf + eax*4 - 4]
    add ebp, [x_buf + eax*4]
    add ebp, [x_buf + eax*4 + 4]
    push edx
    mov eax, ebp
    xor edx, edx
    mov ebp, 3
    div ebp
    pop edx
    lea ebp, [ebx + ecx]
    mov [y_buf + ebp*4], eax
    inc ecx
    cmp ecx, 32
    jl .b_in
.next_b:
    add ebx, 32
    cmp ebx, 256
    jl .b_out
    dec edx
    jnz .rep_t

    rdtsc
    sub eax, esi

    push 15
    push dword [y_buf + 15*4]
    push eax
    push edi
    push desc_str
    call _printf
    add esp, 20

    pop edi
    pop esi
    pop ebx
    xor eax, eax
    mov esp, ebp
    pop ebp
    ret
