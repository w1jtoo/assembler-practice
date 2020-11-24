.include "macro.s"
.include "parse_int.s"

.globl _start
.data
    format:         .asciz "%i\n"
    error_line:     .asciz "Too less atguments\n"

.text
_start:
    mov (%rsp), %ecx
    cmp $2, %ecx
    jle _exit_with_error

    mov 16(%rsp), %rdi      # take first param
    call parse_int          # parse, args[0] -> rax
    mov %rax, %rsi          # parsed args[0] -> rdi

    mov 24(%rsp), %rdi
    call parse_int          # parse, args[1] -> rax

    mult_reg %eax, %esi

    mov %rax, %rsi
    mov $0, %rax
    mov $format, %rdi
    call printf

_exit:
    call exit

_exit_with_error:
    mov %rax, %rsi
    mov $0, %rax
    mov $error_line, %rdi
    call printf
    jmp _exit
