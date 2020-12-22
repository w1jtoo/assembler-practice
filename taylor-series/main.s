.include "parse-int.s"
.include "macro.s"
.include "std-utils.s"
.include "math-utils.s"

.data
.align 4
promt:          .ascii "Please, enter degrees: "
promtl = . - promt

result1:        .ascii "Sin of "
result_number:  .ascii "  "
number2:        .ascii " degrees equals "
resultl = . - result1

error_promt:    .ascii "Error\n"
error_promtl = . - error_promt

number_buffer:
    .rept 15
        .byte 0x0
    .endr
number_bufferl = . - number_buffer
ENDL           = 0xA
.text
.globl _start

_start:
    PRINT promt, promtl
    READ  number_buffer, number_bufferl

    mov     $number_buffer, %r9
    xor     %r10, %r10
    mov     (%r10, %r9), %bl

    cmp     $0x30, %bl
    jl      _try_again

    cmp     $0x3a, %bl     # if char < 32 => not integer
    jg      _try_again      # try again

    mov     %rbx, %rdi
    mov     %rbx, %rax
    sub     $0x30, %rax     # rdi <- first number

    inc     %r10
    mov     (%r10, %r9), %bl

    cmp     $ENDL, %bl
    je      _skip

    cmp     $0x0, %bl
    je      _skip

    cmp     $0x30, %bl
    jl      _try_again

    cmp     $0x3a, %rbx
    jg      _try_again

    mov     $10, %rcx
    mul     %cx             # rax *= 10

    sub     $0x30, %bx
    add     %bx, %ax

_skip:
1:
    inc     %r10
    mov     (%r10, %r9), %bl

    cmp     $0x0, %bl
    je      2f

    cmp     $ENDL, %bl
    je      2f

    jmp     _try_again
2:
    cmp     $(number_bufferl - 2), %r10
    jne 1b

    cmp     $90, %ax
    jg      _try_again

    mov     %rax, %rdi
    call    to_radian
    call    ssin

    xor     %rdx, %rdx

    mov     $10, %rbx
    div     %rbx

    add     $0x30, %edx
    add     $0x30, %eax

    mov     %al, result_number
    mov     %dl, (result_number + 1)

    PRINT   result1, resultl
    jmp     _exit

_try_again:
    PRINT error_promt, error_promtl
_exit:
    EXIT 0
