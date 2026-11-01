; Lab 5 Task 8 - Direct-Mapped Cache Thrashing
global _main
extern _printf

section .data
    title_msg db "--- Lab 5 Task 8: Direct-Mapped Cache Conflict Thrashing ---", 10, 0
    desc_msg  db "P1 and P2 separated by exactly 8 KB (8192 Bytes). Both map to same set index.", 10
              db "Alternating 2,000 accesses: Misses = %d, Hits = %d (100%% Miss Rate).", 10
              db "Working set of 8 bytes thrashes entire 8 KB cache capacity.", 10, 0

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

    ; Simulation
    xor esi, esi ; hits
    xor edi, edi ; misses
    mov ecx, 2000
    mov edx, -1
.l_thrash:
    test ecx, 1
    jz .p1
    mov eax, 1
    jmp .chk
.p1:
    mov eax, 0
.chk:
    cmp eax, edx
    je .h
    inc edi
    mov edx, eax
    jmp .next
.h:
    inc esi
.next:
    dec ecx
    jnz .l_thrash

    push esi
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
