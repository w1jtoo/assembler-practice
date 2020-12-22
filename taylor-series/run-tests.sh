# Compile tests add assembly with GCC and run tests
# TODO: do not use gcc, just link binaries from build.sh

gcc -no-pie -lm tests.c math-utils.s std-utils.s -o bin/tests.elf
./bin/tests.elf
