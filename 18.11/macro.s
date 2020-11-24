.macro mult n1=$1 n2=$1
    mov \n1, %ecx
    mov \n2, %eax
    mul %ecx
.endm

.macro mult_reg reg1 reg2
    mov \reg1, %ecx
    mov \reg2, %eax
    mul %ecx
 .endm
