; Lab 4 Task 17 - Modulo Scheduled Software Pipelining
global _main
extern _printf

section .data
    title_str db "--- Lab 4 Task 17: Software Pipelining (Modulo Scheduling) ---", 10, 0
    desc_str  db "Kernel performs Store(k), Compute(k+1), and Load(k+2) simultaneously.", 10
              db "Verified elements: Y[0]=%d, Y[1]=%d, Y[99]=%d", 10, 0

    align 16
    in_x  times 100 dd 5
    out_y times 100 dd 0

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

    ; Prologue
    mov eax, [in_x]
    lea ebx, [eax*2 + 8]
    mov eax, [in_x + 4]
    mov edx, ebx
    lea ebx, [eax*2 + 8]
    mov eax, [in_x + 8]

    ; Kernel
    xor ecx, ecx
.k_loop:
    mov [out_y + ecx*4], edx
    mov edx, ebx
    lea ebx, [eax*2 + 8]
    mov eax, [in_x + ecx*4 + 12]
    inc ecx
    cmp ecx, 98
    jl .k_loop

    ; Epilogue
    mov [out_y + 98*4], edx
    mov [out_y + 99*4], ebx

    push dword [out_y + 99*4]
    push dword [out_y + 4]
    push dword [out_y]
    push desc_str
    call _printf
    add esp, 16

    pop edi
    pop esi
    pop ebx
    xor eax, eax
    mov esp, ebp
    pop ebp
    ret
