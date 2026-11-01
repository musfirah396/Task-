; Lab 5 Task 12 - XOR Cache Index Hashing
global _main
extern _printf

section .data
    title_msg db "--- Lab 5 Task 12: Cache Index Hashing Emulation ---", 10, 0
    desc_msg  db "Index_hashed = Index_raw XOR (Tag & Mask)", 10
              db "Redistribution trace: Addr=0x%08X -> Raw Set %d -> Hashed Set %d", 10, 0

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

    ; Addr 0x00020000
    mov eax, 0x00020000
    mov ebx, eax
    shr ebx, 6
    and ebx, 0xFF       ; raw index

    mov ecx, eax
    shr ecx, 14
    and ecx, 0xFF

    mov edx, ebx
    xor edx, ecx        ; hashed index

    push edx
    push ebx
    push eax
    push desc_msg
    call _printf
    add esp, 16

    pop edi
    pop esi
    pop ebx
    xor eax, eax
    mov esp, ebp
    pop ebp
    ret
