.macro EXIT code
    mov $60, %rax
    mov $\code, %rdi
    syscall
.endm

.macro PRINT msg, lmsg
    mov     $1, %rax
    mov     $1, %rdi
    mov     $\msg, %rsi
    mov     $\lmsg, %rdx
    syscall
.endm

.macro READ buffer, len
    mov     $0, %rax
    mov     $0, %rdi
    mov     $\buffer, %rsi
    mov     $\len, %rdx
    syscall
.endm

.altmacro

.macro irq_insertX number
    .section .text
    irq_stubX \number

    .section .data
    .long irq\number
.endm

.section .data
default_handlers:
.set i,0
.rept 256
    irq_insertX %i
    .set i, i+1
.endr
