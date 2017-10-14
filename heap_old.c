#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <unistd.h>

void evil() {
	char *data = malloc(10 * 1024 * 1024);
	printf("%x\n", data);
}

int main(int argc, char **argv)
{
	printf("Starting...\n");
	evil();
	printf("Exitting...\n");

	return 0;
}
