#include <stdlib.h>
#include <stdio.h>

extern float get_number();

int main(void) { 
    //int a;
    //int b;
    //scanf("%i", &a);
    //scanf("%i", &b);

    printf("x=%f\n\r", get_number());
    return 0;
}
