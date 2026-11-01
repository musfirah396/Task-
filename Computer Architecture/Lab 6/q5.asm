; Lab 6 Problem 5 - Direct-Mapped Cache Simulator
global _main
extern _printf

section .data
    title_str db "--- Lab 6 Problem 5: Software Direct-Mapped Cache Simulator ---", 10, 0
    spec_str  db "4 lines, 16 B/line: Offset [3:0], Set Index [5:4], Tag [31:6]", 10, 0
    res_fmt   db "  Address 0x%08X -> Tag 0x%X, Set %d -> %s", 10, 0
    hit_msg   db "CACHE HIT!", 0
    miss_msg  db "CACHE MISS (Allocated)", 0

    valid_arr db 0, 0, 0, 0
    align 4
    tag_arr   dd 0, 0, 0, 0

section .text
sim_lookup:
    ; offset = bits 3:0
    ; index = bits 5:4
    mov ebx, eax
    shr ebx, 4
    and ebx, 3          ; set index in ebx
    mov ecx, eax
    shr ecx, 6          ; tag in ecx

    movzx edx, byte [valid_arr + ebx]
    test edx, edx
    jz .miss
    cmp ecx, [tag_arr + ebx*4]
    je .hit

.miss:
    mov byte [valid_arr + ebx], 1
    mov [tag_arr + ebx*4], ecx
    xor eax, eax        ; return 0 (Miss)
    ret
.hit:
    mov eax, 1          ; return 1 (Hit)
    ret

_main:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi

    push title_str
    call _printf
    add esp, 4

    push spec_str
    call _printf
    add esp, 4

    ; 1. Access 0x10 -> Miss
    mov eax, 0x10
    call sim_lookup
    push miss_msg
    push ebx
    push ecx
    push 0x10
    push res_fmt
    call _printf
    add esp, 20

    ; 2. Access 0x14 -> Hit (same block)
    mov eax, 0x14
    call sim_lookup
    push hit_msg
    push ebx
    push ecx
    push 0x14
    push res_fmt
    call _printf
    add esp, 20

    pop edi
    pop esi
    pop ebx
    xor eax, eax
    mov esp, ebp
    pop ebp
    ret
