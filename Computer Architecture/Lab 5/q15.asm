; Lab 5 Task 15 - Write-Through vs Write-Back Pressure
global _main
extern _printf

section .data
    title_msg db "--- Lab 5 Task 15: Write-Through vs. Write-Back Buffer Pressure ---", 10, 0
    desc_msg  db "Executing 50,000 stores:", 10
              db "  Repeated stores to single address : %u cycles (Absorbed by dirty bit)", 10
              db "  Stores to dispersed addresses      : %u cycles (Store buffer saturated)", 10
              db "Write-back minimizes external bus write traffic.", 10, 0

    align 64
    target_c dd 0
    align 64
    disp_buf times 32768 dd 0

section .text
_main:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi

    push title_msg
    call _printf
    add esp, 4

    ; Single
    rdtsc
    mov esi, eax

    mov ecx, 50000
    lea edx, [target_c]
.l_one:
    mov [edx], ecx
    dec ecx
    jnz .l_one

    rdtsc
    sub eax, esi
    mov edi, eax

    ; Dispersed
    rdtsc
    mov esi, eax

    mov ecx, 50000
    xor edx, edx
.l_disp:
    mov [disp_buf + edx*4], ecx
    add edx, 16
    and edx, 32767
    dec ecx
    jnz .l_disp

    rdtsc
    sub eax, esi

    push eax
    push edi
    push desc_msg
    call _printf
    add esp, 12

    pop edi
    pop esi
    pop ebx
    xor eax, eax
    mov esp, ebp
    pop ebp
    ret
