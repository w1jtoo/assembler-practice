.globl int_to_str
.globl float_to_str

# gets str value of int
#   !DO NOT SAVES CONTEXT!
#
# rcx -- index
# r9  -- pointer
# rax -- result
insert_str_value:
.Lloop1:                        # while true do
    mov     $10, %rbx
    xor     %rdx, %rdx

    div     %rbx                # rax /= 10

    add     $0x30, %rdx         # result[i] = rax + '0'
    mov     %dl, (%rcx, %r9)

    cmp     $0x0, %rax
    je      .Lendl              # if rax == 0 break

    dec     %rcx                # if rcx(index) == -1 break
    js      .Lendl

    jmp     .Lloop1

.Lendl:
    ret

strip:
.Lcheck_loop:                       # skip empty bytes
    inc     %rax                            # do
    mov     (%rax), %dl                     #   i += 1
    cmp     $0x0, %dl                       # while buffer[i] == 0
    je     .Lcheck_loop

    ret


# rdi -- number
#   rdi -> rax
# rax -- pointer to string of number with zero on the end
.bss
.Lnumber_buffer:
    .rept 19
        .byte 0x0
    .endr
number_bufferl = . - .Lnumber_buffer

.text
int_to_str:
    push    %rcx        # save context
    push    %rbx        # TODO: write macro
    push    %rdx
    push    %r9

    mov     $(number_bufferl - 1), %rcx
    mov     $.Lnumber_buffer, %r9
    mov     %rdi, %rax
    call    insert_str_value                # iserts int value of rax
                                            #   to buffer

    mov     $.Lnumber_buffer, %rax          # result is ptr to number
    call    strip                           # skip zero bytes

    pop     %r9
    pop     %rdx
    pop     %rbx
    pop     %rcx

    ret

# Function float_to_str
#   takes float number and convert it to
#   ptr of ASCII formated float number
# xmm0 -- number
#   xmm0 -> rax
# rax  -- ptr to string
.bss
.Lnumber:           .long   0
.Lfpu_controlword:  .long   0
.Lint_part:         .long   0
.Lfloat_part:       .long   0

.data
.Lresult:
                .rept (20 + 1)      # int part (MAX=20) of 0x0
                    .byte 0x0           #   + dot symbol (=1)
                .endr                   #       of 0x0
                .rept 8
                    .byte 48
                .endr                   #   + float part (MAX=8)
resultl = . - .Lresult                  #       of '0'

.section rdata, "a"          # readonly data segment
.Lexp:               .long   100000000

.text
float_to_str:
    movss   %xmm0, .Lnumber     # getting number from SSE
    finit                       # reset/init fpu

    # make fpu do not round the integer by
    #       setting control word settings
    # so bit number 0xA should be setted to
    #       value 0b11
    # 11b enable truncate mode
    fstcw   .Lfpu_controlword               # getting fpu control word
    mov     .Lfpu_controlword, %ax
    or      $0b110000000000, %eax           # set rounding control
    mov     %ax, .Lfpu_controlword
    fldcw   .Lfpu_controlword               # load new control word

    flds    .Lnumber
    fists   .Lint_part                      # int_part = floor(number)

    finit                   # reset/init fpu

    fildl   .Lint_part      # stack: [int_part]
    flds    .Lnumber        #   [number, number] 
    fsubp                   #   [number - int_part] calling sub
    fildl    .Lexp          #   [number - int_part, exp(10**9)]
    fmulp                   #   [(number - int_part) * exp(10**9)]

    fistl   .Lfloat_part    # float_part = stack peek value
    finit                   # reset fpu

    # now there are float_part and int part
    #   so just construct result string as "<int_part>.<float_part>"
    push    %rcx        # TODO: save context using macro
    push    %rbx
    push    %rdx
    push    %r9

    mov     $(20 - 1), %rcx         # insert int part to fisrt 20 bytes
    mov     $.Lresult, %r9
    mov     .Lint_part, %eax
    call insert_str_value

    mov     $20, %rcx               # insert dot char
    movb    $'.', (%rcx, %r9)

    mov     $(resultl-1), %rcx      # insert float part to last 9 bytes
    xor     %rax, %rax
    mov     .Lfloat_part, %eax
    call insert_str_value

    mov     $.Lresult, %rax         # ptr to result str now in rax

    call    strip                   # skip empty bytes

    pop     %r9
    pop     %rdx
    pop     %rbx
    pop     %rcx

    ret

