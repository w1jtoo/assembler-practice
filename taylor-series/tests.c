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

extern int fact(int number);
extern float fsin(float number);

int main(void) {
    printf("Running tests...\n");
    ASSERT_EQ(TRUE, 1, 1);
    ASSERT_EQ(FALSE, 1, 0);
    return 0;
}
