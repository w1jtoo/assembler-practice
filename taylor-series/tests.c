#include <stdio.h>
#include <math.h>
#include <string.h>

#define ASSERT_EQ(NAME, EXP, ACT)   assert_eq(""#NAME"", EXP, ACT)
#define ASSERT_FEQ(NAME, EXP, ACT)  assert_float_eq(""#NAME"", EXP, ACT)
#define ASSERT_SEQ(NAME, EXP, ACT)  assert_str_eq(""#NAME"", EXP, ACT)

#define EPSILON                     1e-6
#define PI                          3.14159265358979323846

void assert_eq(char *const test_name, int expected, int actual) {
    if(expected == actual)
        printf("\tPASSED | %s\n", test_name);
    else {
        printf("\tFAILED | %s\n", test_name);
        printf("\t\tExpected %i but was %i\n", expected, actual);
    }
}

void assert_float_eq(char *const test_name, float expected,
                                            float actual) {
    if(fabs(expected - actual) < EPSILON)
        printf("\tPASSED | %s\n", test_name);
    else {
        printf("\tFAILED | %s\n", test_name);
        printf("\t\tExpected %f but was %f\n", expected, actual);
    }
}

void assert_str_eq(char *const test_name, char* const expected,
                                            char* const actual) {
    if(!strcmp(expected, actual))
        printf("\tPASSED | %s\n", test_name);
    else {
        printf("\tFAILED | %s\n", test_name);
        printf("\t\tExpected %s but was %s\n", expected, actual);
    }
}


// extern testing methods
extern long int fact(long int number);
extern float ssin(float number);
extern float fpow(float number, int exp);
extern float to_radian(int angle);
extern char* int_to_str(int number);
extern char* float_to_str(float number);

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
    ASSERT_FEQ(ZeroPower, 1, fpow(1.f, 0));
    ASSERT_FEQ(BigExp, 729, fpow(3.f, 6));
    ASSERT_FEQ(fpowEqCMuptiply, 3.14f * 3.14f, fpow(3.14f, 2));

    printf("\nSin function tests\n");
    ASSERT_FEQ(ZeroSin, 0, ssin(0.f));

    printf("\nSin function tests -- compare with math.h sinf\n");

    float p = 0.f;
    while (p <= 1.f) {
        ASSERT_FEQ(CompareWithStdSin, sinf((double) p), ssin(p));
         p += 0.05f;
    }

    printf("\nGet rad from degrees from function tests\n");
    ASSERT_FEQ(ZeroTest, 0.f, to_radian(0));
    ASSERT_FEQ(90DegreesEqPi/2Test, PI / 2, to_radian(90));
    ASSERT_FEQ(45DegreesEqPi/4Test, PI / 4, to_radian(45));
    ASSERT_FEQ(30DegreesEqPi/6Test, PI / 6, to_radian(30));
    ASSERT_FEQ(1DegreeEqPi/180Test, PI / 180, to_radian(1));

    printf("\nCreate string from int function tests\n");
    ASSERT_SEQ(ZeroIntTest, "0", int_to_str(0));
    ASSERT_SEQ(BigIntTest, "123456789", int_to_str(123456789));

    printf("\nCreate string from float function tests\n");
    ASSERT_SEQ(ZeroIntTest, "0.00000000", float_to_str(0.f));
    ASSERT_SEQ(ZeroIntTest, "12345.00000000", float_to_str(12345.f));

    return 0;
}
