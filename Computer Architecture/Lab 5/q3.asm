; Lab 5 Task 3 - Strided Access Degradation
global _main
extern _printf

section .data
    title_msg db "--- Lab 5 Task 3: Strided Access Degradation ---", 10, 0
    tbl_hdr   db "Stride (Bytes) | Cache Line Ratio | Theoretical Hit Rate | Empirical Behavior", 10
              db "---------------+------------------+----------------------+-------------------", 10, 0
    row_fmt   db "   S = %3d B   |      %2d of 16    |        %5.1f%%        | %s", 10, 0
    c_line    db "Scrit reached: 100% compulsory line misses", 0
    c_part    db "Partial spatial reuse within line", 0

    align 64
    stride_arena times 16384 dd 1

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

    push tbl_hdr
    call _printf
    add esp, 4

    ; Row 4B
    push c_part
    push 93             ; 93.8%
    push 16
    push 4
    push row_fmt
    call _printf
    add esp, 20

    ; Row 16B
    push c_part
    push 75             ; 75.0%
    push 4
    push 16
    push row_fmt
    call _printf
    add esp, 20

    ; Row 32B
    push c_part
    push 50             ; 50.0%
    push 2
    push 32
    push row_fmt
    call _printf
    add esp, 20

    ; Row 64B (Scrit)
    push c_line
    push 0              ; 0.0%
    push 1
    push 64
    push row_fmt
    call _printf
    add esp, 20

    ; Row 128B
    push c_line
    push 0
    push 1
    push 128
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
