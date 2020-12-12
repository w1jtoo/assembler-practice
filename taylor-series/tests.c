#include <stdio.h>
#define ASSERT_EQ(NAME, EXP, ACT) assert_eq(""#NAME"", EXP, ACT)

void assert_eq(char *const test_name, int expected, int actual) {
    if(expected == actual)
        printf("\tPASSED | %s\n", test_name);
    else {
        printf("\tFAILED | %s\n", test_name);
        printf("\t\tExpected %i but was %i\n", expected, actual);
    }
}

extern long int fact(long int number);
extern float fsin(float number);

int main(void) {
    printf("Running tests...\n");
    ASSERT_EQ(FactorialOf0, fact(0), 1);
    ASSERT_EQ(FactorialOf1, fact(1), 1);
    ASSERT_EQ(FactorialOf2, fact(2), 2);
    ASSERT_EQ(FactorialOf3, fact(3), 6);
    ASSERT_EQ(FactorialOf4, fact(4), 24);
    ASSERT_EQ(FactorialOf5, fact(5), 120);
    ASSERT_EQ(FactorialOf6, fact(6), 720);
    return 0;
}
