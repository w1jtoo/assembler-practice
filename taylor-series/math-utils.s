.globl fact
.globl fsin
.globl fpow

.text

# calculate factorial of positive interger number
#   rdi -> rax
# rdi -- number
# rax -- result
fact:
    push    %rdx
    mov     %rdi, %rax              # result = arg1

    1:
        dec     %rdi                # arg -= 1
        jz      2f                  # if arg non zero result *= arg
        js      3f                  # else result = 1

        mul     %rdi
        inc     %rcx

        jmp     1b
    3:
        inc     %rax

    2:
        pop     %rdx
        ret

# calculate sin of float number using taylor series
#   xmm0 -> xmm0
# xmm0 -- number 
# xmm0 -- result
fsin:
    ret

# calculate positive integer power of float number
#   xmm0, rdi -> xmm0
# xmm0 -- base
# rdi  -- exponent
.data
.align 4
_one:   .long 0

.text
fpow:
        finit
        fld1
        fsts     _one
        movss    _one, %xmm1
    1:
        dec     %rdi
        js      2f
        mulps   %xmm0, %xmm1
        jmp     1b
    2:
        movss   %xmm1, %xmm0
        ret
