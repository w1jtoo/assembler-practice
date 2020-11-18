.text
    .globl _start
        _start:
            movabs $0x3ffffffff, %rcx
        1:
            nop
            nop
            nop
            dec %rcx
            jnz 1b

            mov $60, %eax
            syscall
