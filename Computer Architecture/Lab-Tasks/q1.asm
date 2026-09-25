global _main
extern _printf

section .data

; %d tells printf to display a decimal number.
; 10 creates a new line.
; 0 marks the end of the string.
format db "Value in AL = %d", 10, 0

section .text

_main:
    ; Put decimal 10 into AL.
    ; AL is an 8-bit register.
    mov al, 10

    ; printf works with larger values.
    ; MOVZX copies AL into EAX and fills
    ; the remaining bits with zeros.
    movzx eax, al

    ; Function parameters are pushed onto
    ; the stack from right to left.
    push eax

    ; Push the address of the format string.
    push format

    ; Call the printf function.
    call _printf

    ; Two 32-bit values were pushed.
    ; Each value used 4 bytes.
    ; Remove 8 bytes from the stack.
    add esp, 8

    ; Return 0 from the program.
    xor eax, eax
    ret
