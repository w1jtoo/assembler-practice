.include "macro.s"
.include "parse_int.s"

.globl _start
.data
    format:         .asciz "%i\n"
    less_error_line:     .asciz "Too less arguments\n"
    much_error_line:     .asciz "Too much arguments\n"

.text
_start:
    mov (%rsp), %ecx
    cmp $3, %ecx
    jne _exit_with_error

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

    mov (%rsp), %ecx
    cmp $3, %ecx
    jg _much_arguments
    mov $less_error_line, %rdi

_exit_ret:
    call printf
    jmp _exit

_much_arguments:
    mov $much_error_line, %rdi
    jmp _exit_ret
