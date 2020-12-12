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
extern float fpow(float number, int exp);

int main(void) {
    printf("Running tests...\n");
    printf("Factorial function tests\n");
    ASSERT_EQ(FactorialOf0, fact(0), 1);
    ASSERT_EQ(FactorialOf1, fact(1), 1);
    ASSERT_EQ(FactorialOf2, fact(2), 2);
    ASSERT_EQ(FactorialOf3, fact(3), 6);
    ASSERT_EQ(FactorialOf4, fact(4), 24);
    ASSERT_EQ(FactorialOf5, fact(5), 120);
    ASSERT_EQ(FactorialOf6, fact(6), 720);

    printf("\nPower function tests\n");
    // TODO: write right assert float eq macro
    ASSERT_EQ(ZeroPower, 1, fpow(1.f, 0));
    ASSERT_EQ(BigExp, 729, fpow(3.f, 6));
    ASSERT_EQ(fpowEqCMuptiply, 3.14f * 3.14f, fpow(3.14f, 2));

    return 0;
}
