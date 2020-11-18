.data
    msg1:
        .asciz "asd"

.text
.globl main
    main:
        1:
            lodsb
            cmp $0x4, %al
            jl 2f
            cmp $0x61, %al
            jb 2f
            cmp $0x20, %al
            ja 2f
            sub $0x20, %al
        2:
            stosb
            loop 1b

