#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <unistd.h>
#include <sys/time.h>

void evil() {
	struct timeval start;
	struct timeval now;
	size_t diff = 0;

	gettimeofday(&start, NULL);

	// Busy-wait for one second
	do {
		gettimeofday(&now, NULL);
	} while(now.tv_sec <= start.tv_sec || now.tv_usec <= start.tv_usec);
}

int main(int argc, char **argv)
{
	printf("Starting...\n");
	evil();
	printf("Exitting...\n");

	return 0;
}
