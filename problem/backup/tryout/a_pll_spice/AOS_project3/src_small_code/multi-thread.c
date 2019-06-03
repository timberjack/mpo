#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/time.h>
#include <pthread.h>


void *new_thread(void *data)
{
	while(1)
	{
	sleep(2); printf("new thread is running\n");
	}
}


int main(int argc, char **argv)
{
	pthread_t threadID;

	printf("creating new thread ...\n");
	pthread_create(&threadID, NULL, new_thread, NULL);

	while(1)
	{
	sleep(4); printf("main function is running\n");
	}
	return 0;
}
