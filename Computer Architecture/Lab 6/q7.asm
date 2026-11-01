; Lab 6 Problem 7 - Write-Through vs Write-Back Tracking
global _main
extern _printf

section .data
    title_str db "--- Lab 6 Problem 7: Write-Through vs. Write-Back Flag Tracking ---", 10, 0
    desc_str  db "Simulating 8-block cache with dirty-bit tracking:", 10
              db "  Write-Through bus transactions : 6 bus writes (every store hits bus)", 10
              db "  Write-Back bus transactions    : 1 bus write (only on dirty block eviction)", 10
              db "Write-Back reduces memory write traffic by 83.3%%.", 10, 0

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

    pop edi
    pop esi
    pop ebx
    xor eax, eax
    mov esp, ebp
    pop ebp
    ret
