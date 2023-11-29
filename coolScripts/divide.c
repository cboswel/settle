#include <stdio.h>
#include <limits.h>
#include <stdlib.h>

int main(int argc, char **argv) {

	char *p;
	float one = strtol(argv[1], &p, 10);
	float two = strtol(argv[2], &p, 10);
	float ans = one/two;
	printf("%f", ans);
	return ans;
}

