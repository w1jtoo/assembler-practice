.globl _start
.data
m1:     .word 0
m2:     .word 2
m3:     .word 3
m4:     .word 0x28

_start:
    # registers 
    mov     %cx,    %ax
    # непосредственная адресация
    mov     $4,     %rcx
    mov     $m1,    %rcx
    movabs  $m2,    %rsi
    # прямая адресация
    mov     0x100,              %si
    mov     m1,                 %eax
    # косвенная адресация
    mov     (%rsi),             %ax
    mov     (%rsi),             %eax
    # по базе со сдвигом
    mov     2(%rbp),            %ax
    # косвенная с маштабированием
    mov     4(,%rsi, 2),        %ax
    mov     2(%rbx, %rbp, 4),   %rax
