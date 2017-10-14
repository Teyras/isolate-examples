#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <unistd.h>

void evil() {
	srand(1993);

	size_t size = 1024;
	size_t pagesize = 4096;
	char *data = malloc(size * pagesize);
	printf("%x\n", data);
	size_t i;

	for (i = 0; i < size; i++) {
		int offset = rand() % size;
		printf("%zu %d\n", i, offset);
		data[offset * pagesize] = 42;
	}
}

int main(int argc, char **argv)
{
	printf("Starting...\n");
	evil();
	printf("Exitting...\n");

	return 0;
}
