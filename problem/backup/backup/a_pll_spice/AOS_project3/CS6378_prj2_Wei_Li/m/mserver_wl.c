/* A simple server in the internet domain using TCP.  The port number is passed as an argument */
/* Acknowledgement: http://www.linuxhowtos.org/C_C++/socket.htm */

#include <stdio.h>   	/*input and output and is typically included in all C programs*/
#include <stdlib.h>  	/*includes functions involving memory allocation, process control, conversions and others*/
#include <unistd.h>  	/*provides access to operating system API*/
#include <string.h>  	/*contains macro definitions, constants, and declarations of functions and types used not only for string handling but also various memory handling functions*/
#include <sys/types.h>   /*a number of data types used in system calls. These types are used in the next two include files*/
#include <sys/socket.h>  /*The header file socket.h includes a number of definitions of structures needed for sockets*/
#include <netinet/in.h>  /*contains constants and structures needed for internet domain addresses*/
#include <netdb.h>       /*definitions for network database operations*/
#include <time.h> 		 /* This header file contains definitions of functions to get and manipulate date and time information.*/

void CHECKsvr();										/* Check the status of servers' files */
void ctrlstuff(int sock, char cmds[64], char file[64]);	/* function prototype */
void error(const char *msg)
{perror(msg);                                          // This function is called when a system call fails.                           
 exit(1);}                                             // It displays a message about the error on stderr and then aborts the program.

int main(int argc, char *argv[])
{    socklen_t clilen;
     int sockfd, newsockfd, pid, portno = 6659;                                           /**MetaServer = 6659!!!**/
     struct sockaddr_in serv_addr, cli_addr;
	 char cmds[64], file[64];												// status[i][64], i=# of clients
	 int i, j;
	 FILE *fp;
	 
	 fp=fopen("meta_a","w"); fclose(fp);
	 fp=fopen("meta_b","w"); fclose(fp);
     sockfd = socket(AF_INET, SOCK_STREAM, 0);
     if (sockfd < 0) error("ERROR opening socket");
     bzero((char *) &serv_addr, sizeof(serv_addr));
     serv_addr.sin_family = AF_INET;
     serv_addr.sin_addr.s_addr = INADDR_ANY;
     serv_addr.sin_port = htons(portno);
     if (bind(sockfd, (struct sockaddr *) &serv_addr, sizeof(serv_addr)) < 0) error("ERROR on binding");
     listen(sockfd,5);
     clilen = sizeof(cli_addr);
     while (1) { bzero(cmds,64); bzero(file,64);
		 newsockfd = accept(sockfd, (struct sockaddr *) &cli_addr, &clilen);
         if (newsockfd < 0) error("ERROR on accept");
         pid = fork();
         if (pid < 0) error("ERROR on fork"); 
         if (pid == 0)  {close(sockfd);
		     read(newsockfd,cmds,64);
			 read(newsockfd,file,64);
			 ctrlstuff(newsockfd,cmds,file);		 
			 exit(0);}	
         else close(newsockfd);
     } close(sockfd);                            										/* end of while, while(0) */
     return 0;                                   										/* we never get here */
}

/***------------------------------ ctrlstuff() ------------------------------
 There is a separate instance of this function for each connection.
 It handles all communication once a connnection has been established.
 ---------------------------------------------------------------------------***/
void ctrlstuff(int sock, char cmds[64], char file[64])					
{  int n, h, k, flag=0;
   int a, i, j;
   char hostinfo[9], hostinfo1[9], hostinfo2[9], hostinfo3[9];
   char status[2][64], filename[2][64];											// status[i][64], i=# of clients.  
   char GP;                                               					    // GP = 0: GRANT, 1: Read protected, 2: Write protected.
   FILE *fp;
   time_t t;
   
	 bzero(status,2*64); strcpy(filename[0],"meta_a"); strcpy(filename[1],"meta_b");
	 h = (int)(cmds[5])-97; k = (h+1)%2;													// a: h0/k1, b: h1/k0
	 strcpy(hostinfo1,"6661net01");	strcpy(hostinfo2,"6662net12"); strcpy(hostinfo3,"6663net13");      /**CHANGE MACHINE No. & NAME!!!**/
	 srand((unsigned) time(&t));
     a = rand()%3+1; switch(a) {case 1: memcpy(hostinfo,hostinfo1,9); break;				// WRONG: hostname = hostname1
								case 2: memcpy(hostinfo,hostinfo2,9); break;
								case 3: memcpy(hostinfo,hostinfo3,9); break;
								default: break;}
     for (i = 0; i < 2; i++){
	 fp=fopen(filename[i],"r");
		for(j = 0; j < 64; j++){
           fscanf(fp,"%c",&status[i][j]); 
           if (status[i][j] == EOF) break;}
	 }fclose(fp);
	 
	if (cmds[0] != '4') {															   		// client check status of a file
	   if (strcmp(&status[k][2],file)==0) GP = status[k][0];								// GP - 0: closed; 1: R_open; 2: W_open.
	   else GP = '0';
	 if (GP=='2') {write(sock,"2",1);}
	 else if ((GP=='1')&&(cmds[0]=='3')) {write(sock,"1",1);}								// Read-Write conflict
	 else { memcpy(&status[h][2],file,62); status[h][1] = '\t'; status[h][0] = cmds[0]-1;
			write(sock,"0",1); write(sock,hostinfo,9);}
	 }
	else if (cmds[0] == '4') { //bzero(status[h],64); 
		status[h][0] = '0'; CHECKsvr();}													// client want to close a file

printf("\nClients' status:\n");		
printf("Client[%d]=%s\t",h,status[h]); printf("Client[%d]=%s\n",k,status[k]);
	fp=fopen(filename[h],"w");
	for(j = 0; j < 64; j++) fputc(status[h][j],fp);
	fclose(fp);
}

/***------------------------------ CHECKsvr() ------------------------------
						Check the status of servers' files
 ---------------------------------------------------------------------------***/
void CHECKsvr()
{   time_t t;
	int portno, sockfd, a, n, i;
    struct sockaddr_in serv_addr;
    struct hostent *server;
    char hostname[5], str[8][64], meta[16][32];
	bzero(meta,16*32); bzero(str,8*64); str[0][0]='4';
	
	srand((unsigned) time(&t)); a = rand()%3+1;
     switch(a) {case 1: strcpy(hostname,"net01"); portno=6661; break;						/**CHANGE MACHINE No. & NAME!!!**/
				case 2: strcpy(hostname,"net12"); portno=6662; break;						/**CHANGE MACHINE No. & NAME!!!**/
				case 3: strcpy(hostname,"net13"); portno=6663; break;						/**CHANGE MACHINE No. & NAME!!!**/
				default: break;}
		
	sockfd = socket(AF_INET, SOCK_STREAM, 0);
    if (sockfd < 0) error("ERROR opening socket");
    server = gethostbyname(hostname);
    if (server == NULL) {fprintf(stderr,"ERROR, no such host\n"); exit(0);}
    bzero((char *) &serv_addr, sizeof(serv_addr));
    serv_addr.sin_family = AF_INET;
    bcopy((char *)server->h_addr, (char *)&serv_addr.sin_addr.s_addr, server->h_length);
    serv_addr.sin_port = htons(portno);
    if (connect(sockfd,(struct sockaddr *) &serv_addr,sizeof(serv_addr)) < 0) error("ERROR opening socket");
	n = write(sockfd,"M",1);  if (n <= 0) printf("Server%d is in use!\n",a);
    n = write(sockfd,str,8*64);  if (n <= 0) printf("Server%d is in use!\n",a);
	n = read(sockfd,meta,16*32);  if (n <= 0) printf("Server%d is in use!\n",a);
    close(sockfd);
	printf("\nMetadata in server%d (%s %d):\n", a,hostname,portno);
	for (i=0;i<16;i++) {if (meta[i][0] != '\0')
		printf("%s\n",meta[i]);} printf("\n");
}
