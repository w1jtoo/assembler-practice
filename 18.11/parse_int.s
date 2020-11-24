.globl parse_int

.text
parse_int:
    push %rcx
    push %rdx
    xor %rbx, %rbx
    xor %rcx, %rcx
    xor %rdx, %rdx
    xor %rax, %rax
    _loop:
        mov (%rbx, %rdi), %ax      # move in rax char on rdi position

        cmp $'0', %al               # if rax < "0" exit
        jb  _rd_ex

        cmp $'9', %al               # if rax > "9" exit
        ja  _rd_ex

        mov %rdx, %rcx
        sal $3, %rdx
        sal $1, %rcx
        add %ecx, %edx

        sub $'0', %rax
        xor %ah, %ah
        add %eax, %edx

        inc %rbx
        jmp _loop

    _rd_ex:
        mov %rdx, %rax

    pop %rdx
    pop %rcx

    ret
