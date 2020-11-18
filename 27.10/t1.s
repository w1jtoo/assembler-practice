.text
.globl _start
_start:
    mov %rdx, %r12

1:
    mov $msg, %rsi
    mov (%r12), %rdi
    xor %eax, %eax

    call printf

    add $8, %r12
    mov (%r12), %rax
    test %rax, %rax
    jnz 1b

    ret

.data
msg:    .asciz "%s\n"
