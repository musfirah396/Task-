; Lab 5 Task 7 - Bit-Field Decoding
global _main
extern _printf

section .data
    title_msg db "--- Lab 5 Task 7: Address Bit-Field Extraction ---", 10, 0
    desc_msg  db "Cache Spec: 4 KB, 32B lines (128 sets) -> Offset [4:0], Index [11:5], Tag [31:12]", 10, 0
    row_fmt   db "  Address 0x%08X -> Tag: 0x%05X | Set: %3d | Offset: %2d", 10, 0

    test_a dd 0x00000000
    test_b dd 0x0000001F
    test_c dd 0x80001FE0

section .text
decode_addr:
    mov ebx, eax
    and ebx, 0x1F       ; offset
    mov ecx, eax
    shr ecx, 5
    and ecx, 0x7F       ; index
    mov edx, eax
    shr edx, 12         ; tag
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

    push desc_msg
    call _printf
    add esp, 4

    ; A
    mov eax, [test_a]
    call decode_addr
    push ebx
    push ecx
    push edx
    push dword [test_a]
    push row_fmt
    call _printf
    add esp, 20

    ; B
    mov eax, [test_b]
    call decode_addr
    push ebx
    push ecx
    push edx
    push dword [test_b]
    push row_fmt
    call _printf
    add esp, 20

    ; C
    mov eax, [test_c]
    call decode_addr
    push ebx
    push ecx
    push edx
    push dword [test_c]
    push row_fmt
    call _printf
    add esp, 20

    pop edi
    pop esi
    pop ebx
    xor eax, eax
    mov esp, ebp
    pop ebp
    ret
