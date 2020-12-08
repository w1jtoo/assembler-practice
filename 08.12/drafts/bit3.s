.globl _start

.text
_start:
    mov $0x1, %eax

    call inc

_end:
    mov $60, %eax
    syscall

inc:
    xor %ecx, %ecx

    1:
        btc %rcx, %rax
# jc _inc_ret
        jnc _inc_ret
        inc %ecx
        jmp 1b

_inc_ret:
    ret

