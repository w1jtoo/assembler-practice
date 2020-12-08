.data
.align 4
_pi:    .long   0
_n:     .long   0
_result: .long   0

.globl get_number

.text

get_number:
    finit
    fldpi
    fsts _pi
    movss _pi, %xmm0
#    fsqrt
#    fistl _result
#    mov $1, %eax
#
#    movss _pi, %xmm0
#    mov $5, %eax
#    movss %eax, %xmm1

#    cvtsi2ss %xmm1, %xmm2
#    cvtsi2sd %xmm1, %xmm3
    ret
