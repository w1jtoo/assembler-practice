.text
.globl _start
_start:
    pop     %r12

    1:
        mov     $1, %edi
        mov     $1, %eax

        pop     %rsi
        call    calc_end
        syscall

        mov     $1, %eax
        mov     %eax, %edi
        mov     $crlf, %rsi
        mov     %eax, %edx
        syscall

        dec     %r12
        jnz     1b

        pop     %rdi
        mov     $60, %eax
        syscall

calc_end:
    xor     %edx, %edx
    push    %rsi
1:
    lodsb
    test    %al, %al
    jz      2f
    inc     %edx
    jmp     1b

2:
    pop     %rsi
    ret

.data
crlf:   .byte   0xa
