.include "macro.s"
.globl _start
.data
    msg:    .ascii "Hello World"
    lmsg = . - msg

.text
_start:
    mov $1, %eax
    exit $4
