#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <unistd.h>

void evil() {
	size_t size = 100 * 1024 * 1024;
	char *data = malloc(size);
	printf("%x\n", data);
	size_t i;

	for (i = 0; i < size; i++) {
		data[i] = 42;
	}
}

int main(int argc, char **argv)
{
	printf("Starting...\n");
	evil();
	printf("Exitting...\n");

	return 0;
}
