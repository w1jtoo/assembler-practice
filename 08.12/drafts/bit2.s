.globl _start
.data
msg:        .ascii "Hello, bitstring\n"
lmsg = . - msg

msg2:   .fill lmsg, 1, 0

.text
_start:
    mov $0x1, %eax
    mov $0x2, %ebx

    call sum

_end:
    mov $60, %eax
    syscall

sum:
    xor %rdx, %rdx
    mov $63, %ecx

    1:
        shl $1, %rdx
        bt %rcx, %rax
        jnc 2f
        inc %rdx
    2:
        bt %rcx, %rbx
        jnc 3f
        inc %rdx
    3:
        dec %ecx
        jns 1b

    ret
