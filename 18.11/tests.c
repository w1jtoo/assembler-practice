#include <assert.h>
#include <stdio.h>

extern int parse_int(const char* str);

int main(void) {
    assert(parse_int("1") == 1);
    assert(parse_int("12") == 12);
    assert(parse_int("333") == 333);
    assert(parse_int("0") == 0);

    printf("Tests passed\n\r");
    return 0;
}
