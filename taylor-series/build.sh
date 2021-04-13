# as -o bin/main.o main.s --gstabs+
as -o bin/main.o main.s

ld -o bin/main.elf bin/main.o
