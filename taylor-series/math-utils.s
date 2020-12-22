.globl fact
.globl ssin
.globl fpow
.globl to_radian

.text

# calculate factorial of positive interger number
# rdi -- number
#   rdi -> rax
# rax -- result
fact:
    push    %rdi
    push    %rcx
    push    %rdx

    cmp     $23, %rdi
    jge     5f

    xor     %rcx, %rcx
    xor     %rdx, %rdx
    mov     %rdi, %rax              # result = arg1

    1:
        dec     %rdi                # arg -= 1
        jz      2f                  # if arg non zero result *= arg
        js      3f                  # else result = 1

        imul    %rdi
        cmp     $0, %rdx            # if rdi has overflow return max value
        jne     5f

        inc     %rcx

        jmp     1b
    3:
        inc     %rax

    2:
        pop     %rdx
        pop     %rcx
        pop     %rdi
        ret

    5:
        mov     $2147483647, %rax
        jmp     2b


# calculate sin of float number using taylor series
# xmm0 -- number
#   xmm0 -> xmm0, rcx
# xmm0 -- result
# rcx -- count of cycles
.text
ssin:
    push    %rax
    push    %rdi                    # iteration scalar k: 3, 5, 7 etc.
    push    %r9                     # uses for sign flipping
                                    # and rcx is iteration counter n

    # ------------------- initialize constants ---------------------#
    mov     $0x80000000, %r9        #  = 2 ^ 31
    movq    %r9, %xmm5

    movss   %xmm0, %xmm1            # xmm0 used for delta
    movss   %xmm0, %xmm2            # xmm1 used for result
                                    # xmm2 used for save argument1
                                    # xmm4 contains positive zero
                                    # xmm5 used for sign flipping
    # --------------------------------------------------------------#

    # first iteration does nothing with registres
    # make preparations for first iteration:
    mov     $1, %rdi                # k = 1
    mov     $1, %rcx

1:                                  # series loop
    movss   %xmm1, %xmm4
    movss   %xmm2, %xmm0
    inc     %rcx
    add     $2, %edi

    # calculate delta := ((-1) ^ n * x ^ k) / (k!)
    call    fpow                    # delta = x ^ k
    call    fact                    # rax = k!
    movq    %rax,  %xmm3
    cvtdq2ps %xmm3, %xmm3

    divps   %xmm3, %xmm0            # delta = delta / k!

    bt      $0, %rcx                #  if last bit is one i.e 
    jc      2f                      #   n % 2 == 1 
    xorps   %xmm5, %xmm0            #   then delta -= delta
2:
    addps   %xmm0, %xmm1            # result += delta

    cmp     $8, %rcx                # TODO: fix bug with
    je      3f                      # wrong asnwer on rcx > 8

    comiss  %xmm4, %xmm1
    jne      1b
3:
    movss   %xmm1, %xmm0

    pop     %r9
    pop     %rdi
    pop     %rax

    ret

# calculate positive integer power of float number
# xmm0 -- base
# rdi  -- exponent
#   xmm0, rdi -> xmm0
# xmm0 --powered number
.bss
    .align 4
        _one:   .long 0
    .align 4
        _store: .long 0

.text
fpow:
        push        %rdi
        movss       %xmm1, _store

        finit
        fld1
        fsts        _one
        movss       _one, %xmm1
        1:
            dec     %rdi
            js      2f
            mulps   %xmm0, %xmm1
            jmp     1b
        2:

        movss       %xmm1, %xmm0

        movss       _store, %xmm1
        pop         %rdi
        ret


# converts degrees to radian value
# radian = pi * degrees / 180
# rdi  -- number
#   rdi -> xmm0
# xmm0 -- result
.bss
    .align 4
        _pi:    .long 0

.text
to_radian:
    push        %r9
    movss       %xmm1, _store

    finit
    fldpi
    fsts        _pi
    movss       _pi,   %xmm0        # ld PI

    mov         $180,  %r9          # ld 180
    movq        %r9,   %xmm1
    cvtdq2ps    %xmm1, %xmm1        # result = pi

    divps       %xmm1, %xmm0        # result /= 180

    movq        %rdi,  %xmm1        # convert number to float
    cvtdq2ps    %xmm1, %xmm1

    mulps       %xmm1, %xmm0        # result *= float

    movss       _store, %xmm1
    pop         %r9
    ret
