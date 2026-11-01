; Lab 6 Problem 1 - Spatial Locality and Line Fetching
global _main
extern _printf

section .data
    title_str db "--- Lab 6 Problem 1: Single-Line Spatial Locality & Cold Misses ---", 10, 0
    trace_hdr db "Word 0: COLD MISS (16-byte block fetched into cache)", 10
              db "Word 1: CACHE HIT (Spatial locality)", 10
              db "Word 2: CACHE HIT (Spatial locality)", 10
              db "Word 3: CACHE HIT (Spatial locality)", 10, 0
    res_str   db "4 Consecutive Word Accesses: 1 Miss, 3 Hits (75%% Hit Rate).", 10, 0

    align 16
    words_data dd 11, 22, 33, 44, 55, 66, 77, 88

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

    push trace_hdr
    call _printf
    add esp, 4

    ; Loop
    xor eax, eax
    xor ecx, ecx
.loop_words:
    add eax, [words_data + ecx*4]
    inc ecx
    cmp ecx, 4
    jl .loop_words

    push res_str
    call _printf
    add esp, 4

    pop edi
    pop esi
    pop ebx
    xor eax, eax
    mov esp, ebp
    pop ebp
    ret
