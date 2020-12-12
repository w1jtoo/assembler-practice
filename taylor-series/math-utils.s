.globl fact
.globl fsin

.text

# calculate factorial of positive interger number
# rdi -- number
# rax -- result
fact:
    push    %rcx
    push    %rdx
    mov     $1, %rax
    mov     $1, %rcx

_loop:
    cmp     %rcx, %rdi
    jl      _ret

    mul     %rcx
    inc     %rcx

    jmp     _loop
_ret:
    pop     %rdx
    pop     %rcx
    ret

fsin:

    ret
