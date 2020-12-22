#include <stdio.h>

extern char* float_to_str(float number);

int main(void) {
    char* n = float_to_str(1.123123f);
    printf("%s", n);
    return 0;
}
