.globl int_to_str

# rdi -- number
#   rdi -> rax
# rax -- result pointer to string of number with zero on the end
.bss
.Lnumber_buffer:
    .rept 19
        .byte 0x0
    .endr
number_bufferl = . - .Lnumber_buffer

.text
int_to_str:
    push    %rcx
    push    %rbx
    push    %rdx
    push    %r9

    mov     $(number_bufferl - 1), %rcx
    mov     $.Lnumber_buffer, %r9
    mov     %rdi, %rax

.Lloop:
    mov     $10, %rbx
    xor     %rdx, %rdx

    div     %rbx

    add     $0x30, %rdx
    mov     %dl, (%rcx, %r9)

    cmp     $0x0, %rax
    je      .Lexit

    dec     %rcx
    js      .Lexit

    jmp     .Lloop

.Lexit:
    mov     $(.Lnumber_buffer - 1), %rax
.Lcheck_loop:
    inc     %rax
    mov     (%rax), %dl
    cmp     $0x0, %dl
    je     .Lcheck_loop

    pop     %r9
    pop     %rdx
    pop     %rbx
    pop     %rcx

    ret

.bss
.Lnumber:           .long   0
.Lfpu_controlword:  .long   0
.Lresult:           .long   0

.text
float_so_str:
    movss   %xmm0, .Lnumber
    finit

    fstcw   .Lfpu_controlword
    mov     .Lfpu_controlword, %ax
    or      $b110000000000, %eax
    mov     %ax, .Lfpu_controlword
    fldcw   .Lfpu_controlword

    flds    .Lnumber
    fists   .Lresult
    ret
