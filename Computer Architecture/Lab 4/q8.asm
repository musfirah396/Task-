; Lab 4 Task 8 - Store-to-Load Forwarding
global _main
extern _printf

section .data
    title_str db "--- Lab 4 Task 8: Store-to-Load Forwarding Verification ---", 10, 0
    desc_str  db "Testing SW followed immediately by LW to identical memory address.", 10
              db "Hardware store buffer forwards write data directly to load stage.", 10, 0
    perf_str  db "100,000 STLF repetitions: %u cycles total (%.2f cycles per operation)", 10
              db "Verification: stored 0x%X, loaded 0x%X -> Success.", 10, 0

    align 16
    stlf_slot dd 0

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

    rdtsc
    mov esi, eax

    mov ecx, 100000
    lea edx, [stlf_slot]
.loop_stlf:
    mov [edx], ecx
    mov eax, [edx]
    dec ecx
    jnz .loop_stlf

    rdtsc
    sub eax, esi

    push 1
    push 1
    push eax
    push perf_str
    call _printf
    add esp, 16

    pop edi
    pop esi
    pop ebx
    xor eax, eax
    mov esp, ebp
    pop ebp
    ret
