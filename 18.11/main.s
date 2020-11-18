.include "macro.s"

.globl main
.data
    format:    .asciz "%i\n"

.text
main:
    # mult $-10, $-2i
    mov 8(%rsp), %ecx
    cmp $1, %ecx
    jle _exit
    
    mov 16(%rsp), %ecx
    mov 24(%rsp), %edi

    mult_reg %ecx %edi
    mov %rax, %rsi
    mov $0, %rax
    mov $format, %rdi
    call printf

_exit:
    call exit
