.data
.align  16
_pi:    .long   0

.globl get_number

.text

get_number:
    finit
    fldpi
    fstl _pi

    vmovss _pi, %xmm0
    ret

#    movss _pi, %xmm1
#    sqrtss %xmm1, %xmm1
#
#    cvtsi2ss %edi, %xmm0
#    cvtsi2ss %esi, %xmm2
#    sqrtss %xmm0, %xmm0
#1:
#    comiss %xmm0, %xmm2
#    jb 2f
#    mulps %xmm1, %xmm0
#    jmp 1b
#2:
#    ret
