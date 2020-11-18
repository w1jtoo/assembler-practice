/*
 * =====================================================================================
 *
 *       Filename:  m.c
 *
 *    Description:  
 *
 *        Version:  1.0
 *        Created:  11/03/2020 01:18:48 PM
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  YOUR NAME (), 
 *   Organization:  
 *
 * =====================================================================================
 */
#include <stdio.h>

int foo(int a, int b) {
	int c;
	c = a + b;
	return c;
}

int main(void) {;
	int c;
	c = foo(1, 2);
	printf("%i", c);
	return 0;
}

