#include <stdio.h>
#include <cstdlib>

int main()
{
	int done;
	done = system("ngspice -b -r invo.txt -o invo.log invo.cir");

	if(!done) printf("Done!\n");
	else printf("Not Done\n");
}
