#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <unistd.h>
#include <string.h>

void evil() {
	size_t i;

	for (i = 0; i < 1024; i++) {
		char *data = malloc(127 * 1024);
		memset(data, 42, 127 * 1024);
		printf("%zu\n", i);
	}
}

int main(int argc, char **argv)
{
	printf("Starting...\n");
	evil();
	printf("Exitting...\n");

	return 0;
}
