.macro exit exit_code=$0
     mov $60, %eax
     xor \exit_code, %edi
     syscall
.endm
