#include <stdio.h>
#include <unistd.h>

volatile int sink = 0;

void evil() {
	size_t huge_size = 1024 * 1024;
	int huge_stack_var[huge_size];

	for (int i = 0; i < huge_size; i++) {
		huge_stack_var[i] = i;
	} 

	for (int i = 0; i < huge_size; i++) {
		sink += huge_stack_var[i];
	} 
}

int main(int argc, char **argv)
{
	printf("Starting...\n");
	evil();
	printf("Exitting...\n");

	return 0;
}
