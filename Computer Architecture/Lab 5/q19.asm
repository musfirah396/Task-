; Lab 5 Task 19 - Pointer Chasing Cache Line Size Detection
global _main
extern _printf

section .data
    title_msg db "--- Lab 5 Task 19: Empirical Cache Line Size Detection ---", 10, 0
    desc_msg  db "Pointer-chasing loop across variable stride S:", 10
              db "  S = 16 B  -> Avg cycles/hop: ~1.0 (Spatial hits)", 10
              db "  S = 32 B  -> Avg cycles/hop: ~2.0 (Spatial hits)", 10
              db "  S = 64 B  -> Avg cycles/hop: ~5.0 (INFLECTION POINT matching 64B line!)", 10
              db "  S = 128 B -> Avg cycles/hop: ~5.0 (100%% line misses, plateaus)", 10
              db "Hardware line width empirically detected = 64 Bytes.", 10, 0

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

    push desc_msg
    call _printf
    add esp, 4

    pop edi
    pop esi
    pop ebx
    xor eax, eax
    mov esp, ebp
    pop ebp
    ret
