.include "parse-int.s"
.include "macro.s"
.include "std-utils.s"
.include "math-utils.s"

.data
ENDL                = 0xA
promt:              .ascii "Please, enter angle degrees: "
promtl              = . - promt

result1:            .ascii "\nSin of "
result_number:      .ascii "  "
number2:            .ascii " degrees equals "
resultl             = . - result1

cycle_count_msg:    .ascii "\nCount of taylor series cycles: "
cycle_count_msgl    = .- cycle_count_msg

error_promt:        .ascii "Unexpected symbol '"
error_char:         .byte   0x0
error_promt1:       .ascii "'. Please enter non-negative"
                    .ascii " number less than 90\n"
error_promtl        = . - error_promt

error_bad_degrees:  .byte 0
                    .byte 0
error_bad_degree:   .ascii " greater than 90. Angle should be"
                    .ascii " less than 90.\n"
error_bad_degreel   = . - error_bad_degrees

new_line:           .byte ENDL
new_linel           = . - new_line
number_buffer:
                    .rept 15
                        .byte 0x0
                    .endr
number_bufferl      = . - number_buffer

.text
.globl _start

_start:
    PRINT   $promt, $promtl
    READ    number_buffer, number_bufferl

    mov     $number_buffer, %r9     # pointer to buffer
    xor     %r10, %r10              # index of char (=0)
    mov     (%r10, %r9), %bl        # char = buffer[index]

    cmp     $0x30, %bl      # if char < 0x30 => not integer
    jl      .Lunexpected_symbol

    cmp     $0x3a, %bl      # if char > 0x3A => not integer
    jg      .Lunexpected_symbol

    mov     %rbx, %rdi
    mov     %rbx, %rax
    sub     $0x30, %rax     # save to rdi first number

    inc     %r10                    # index += 1
    mov     (%r10, %r9), %bl        # char = buffer[index(=1)]

    cmp     $ENDL, %bl      # if char == '\n'
    je      .Lskip          #   goto: skip to skip other chars

    cmp     $0x0, %bl       # if char == 0
    je      .Lskip          #   goto: skip

    cmp     $0x30, %bl              # if char < 0x30 => not integer
    jl      .Lunexpected_symbol

    cmp     $0x3a, %rbx             # if char > 0x3A => not integer
    jg      .Lunexpected_symbol

    mov     $10, %rcx
    mul     %cx             # rax *= 10

    sub     $0x30, %bx      # bx -= 30
    add     %bx, %ax        # summary: ax = ax * 10 + bx

.Lskip:
.Lmain_loop:
    inc     %r10                    # index += 1
    mov     (%r10, %r9), %bl

    cmp     $0x0, %bl               # if char == 0x0
    je      .Lmain_endl             #   continue

    cmp     $ENDL, %bl              # if cahr == '\n'
    je      .Lmain_endl             #   continue

    jmp     .Lunexpected_symbol
.Lmain_endl:
    cmp     $(number_bufferl - 2), %r10     # if out if bounds
    jne     .Lmain_loop                     #   break

    cmp     $90, %ax                # check if sum greater that 90
    jg      .Lbig_angle

    mov     %rax, %rdi
    call    to_radian       # get radian
    call    ssin            # get sin

    push    %rcx            # save count of cycles

    xor     %rdx, %rdx      # add to result msg entered degrees
    mov     $10, %rbx
    div     %rbx
    add     $0x30, %edx     # second_char = 0x30 + sum mod 10
    add     $0x30, %eax     # fist_char   = 0x30 + sum div 10

    mov     %al, result_number          # writing chars
    mov     %dl, (result_number + 1)

    PRINT   $result1, $resultl          # print first part of result msg

    call    float_to_str                # sin as string
    mov     %rax, %r9
    PRINT   %r9, %rcx                   # printing sin result

    PRINT   $cycle_count_msg, $cycle_count_msgl

    pop     %rcx            # print count of cycles
    mov     %rcx, %rdi      # from value saved on stack
    call    int_to_str
    mov     %rax, %r9
    PRINT   %r9, %rcx

    PRINT   $new_line, $new_linel       # print '\n' symbol

    jmp     .Lmain_exit

.Lunexpected_symbol:
    mov     %bl, error_char
    PRINT   $error_promt, $error_promtl
    jmp     .Lmain_exit

.Lbig_angle:
    xor     %rdx, %rdx                  # add to result msg entered degrees
    mov     $10, %rbx
    div     %rbx
    add     $0x30, %edx                 # second_char = 0x30 + sum mod 10
    add     $0x30, %eax                 # fist_char   = 0x30 + sum div 10

    mov     %al, error_bad_degrees      # writing chars
    mov     %dl, (error_bad_degrees + 1)

    PRINT $error_bad_degrees, $error_bad_degreel

.Lmain_exit:
    EXIT 0

# TODO list:
#   - fix sin of ~90 degrees
#   - add string params
#   - use char instead of it's int value
