#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <netinet/in.h>
#include <sys/types.h>
#include <sys/signal.h>


void reaper(int sig);

int main(int argc, char **argv)
{
	(void)signal(SIGINT,reaper); //register interupt signal with function "reaper" defined at the bottom

	while (1)
	{
		printf("return to main function\n");
		sleep(2);
	}
	return 0;
}

void reaper(int sig)
{
	printf("go into interupt\n"); getchar();
	//exit(0); //if you want to exit after Ctrl+C
}

