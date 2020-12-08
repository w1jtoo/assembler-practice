.globl _start
.data
msg:        .ascii "Hello, bitstring\n"
lmsg = . - msg

msg2:   .fill lmsg, 1, 0

.text
# This program copy string bit by bit
_start:
    mov $msg, %rsi
    mov $msg2, %rdi
    mov $lmsg, %ecx
    shl $3, %ecx
    dec %ecx

1:
    bt  %rcx, (%rsi)
    jnc 2f
    bts %ecx, (%rdi)

2:
    dec %ecx
    jns 1b

    mov $msg, %rsi
    call print
    mov $msg2, %rsi
    call print

    mov $60, %eax
    syscall

print:
    mov $1, %eax
    mov $1, %edi
    mov $lmsg, %edx
    syscall
    ret
