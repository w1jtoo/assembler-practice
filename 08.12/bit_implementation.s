# changes non-zero bit in regster to zero bit
# takes reg1 name with % symbol, reg1 should not be %ecx
# O(count of ones plus one)
.macro zero reg1
    push %rcx
    xor %ecx, %ecx
    1:
        bsf \reg1, %rcx
        btr %rcx, \reg1
        jc  1b
    pop %rcx
.endm


# sum reg1, reg2 and puts result in result
# reg1 register that should not be ecx
# reg2 register that should not be ecx
# result
.macro sum r1 r2 result
    push %rcx
    xor \result, \result
    mov $63, %ecx

    1:
        shl $1, \result
        bt %rcx, \r1
        jnc 2f
        inc \result # TODO: change inc call to inc macro
    2:
        bt %rcx, \r2
        jnc 3f
        inc \result # TODO: change inc call to inc macro
    3:
        dec %ecx
        jns 1b
    pop %rcx
.endm

# increment value of reg1 and writes result to reg1
# reg1 should not be ecx
.macro minc reg1
    xor %ecx, %ecx

    1:
        btc %rcx, %rax
# jc _inc_ret
        jnc 2f
        inc %ecx
        jmp 1b
    2:
.endm

# decrement value of reg1 and writes result to reg1
# reg1 should not be ecx
.macro mdec reg1
    xor %ecx, %ecx

    1:
        btc %rcx, %rax
        jc 2f
        inc %ecx
        jmp 1b
    2:
.endm

.globl _start
.text
_start:
    mov $0x55, %eax
    zero %rax
_after_zero: # easy way to check result of macro using GDB
    nop

    xor %r11, %r11
    mov $0x11111, %rbx
    mov $0x12345, %rdx
    sum %rbx, %rdx, %r11
_after_sum:
    nop

    minc %rax
_after_inc:
    nop

    mdec %rax
_after_dec:
    nop

    mov $60, %eax
    syscall
