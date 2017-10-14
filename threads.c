#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <unistd.h>
#include <sys/time.h>
#include <pthread.h>

void *evil(void *arg) {
	volatile int sink = 0;

	for (size_t i = 0; i < 1024 * 1024 * 1024; i++) {
		sink += i * i;
		sink %= 13;
	}

	return NULL;
}

int main(int argc, char **argv)
{
	pthread_t threads[4];

	printf("Starting...\n");

	for (size_t i = 0; i < 4; i++) {
		int rc = pthread_create(&threads[i], NULL, &evil, NULL);
		if (rc == 0) {
			printf("Thread %d created\n", i);
		} else {
			printf("Creation of thread %d failed\n", i);
		}
	}

	for (size_t i = 0; i < 4; i++) {
		pthread_join(threads[i], NULL);
	}

	printf("Exitting...\n");

	return 0;
}
