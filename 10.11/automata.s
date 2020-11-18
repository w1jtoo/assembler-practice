.data
msg:    .asciz "asm"
mmm:    .byte 0, 0xa

.align 4
char_tab:
            .byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 # 0
            .byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 # 1
            .byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 # 2
            .byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 # 3
            .byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 # 4
            .byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 # 5..
            .byte 0,1,0,0,0,0,0,0,0,0,0,0,0,3,0,0 # 6
            .byte 0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0 # 7
            .byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 # 8
            .byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 # 9
            .byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 #
            .byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 #
            .byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 #
            .byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 #
            .byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 #
            .byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 #

state_tab:
            .long 0, 0, 0, 0 # state 0 -- failture state
            .long 0, 2, 0 ,0 # state 1
            .long 0, 0, 3, 0 # state 2
            .long 0, 0, 0, 4 # state 3
            .long 0, 0, 0, 5 # state 3
            .long 0, 0, 0, 0 # state 4

.globl _start
.text
_start:
        mov 8(%rsp), %ecx
        cmp $1, %ecx
        jle _exit

        mov $1, %ecx
        mov 16(%rsp), %rsi
        mov $char_tab, %rdi
1:
        xor %eax, %eax
        xor %ebx, %ebx
        lodsb
        test %al, %al
        jz 2f
        mov (%rdi, %rax, 1), %bl
        mov %ecx, %edx
        shl $4, %edx
        mov state_tab(%rdx, %rbx, 4), %ecx
        jmp 1b
2:
        add $48, %ecx
        mov $mmm, %rax
        mov %ecx, (%rax)

        mov $1, %rax
        mov $1, %rdi
        mov $mmm, %rsi
        mov $3, %rdx
        syscall
        jmp _exit

_exit:
        mov $60, %rax
        mov $0, %rdi
        syscall
