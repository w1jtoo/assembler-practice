# run and build tests
gcc -o bin/tests.elf tests.c parse_int.s
bin/tests.elf
# sudo rm result.elf

# run and build main assembler filei

as -o bin/main.o main.s
ld -o bin/result bin/main.o -lc -I /lib64/ld-linux-x86-64.so.2

echo "run bin/result with args 4 2"
./bin/result 4 2
