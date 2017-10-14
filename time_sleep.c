#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <unistd.h>

void evil() {
	sleep(1);
}

int main(int argc, char **argv)
{
	printf("Starting...\n");
	evil();
	printf("Exitting...\n");

	return 0;
}
