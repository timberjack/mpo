/* A simple server in the internet domain using TCP.  The port number is passed as an argument */
/* Acknowledgement: http://www.linuxhowtos.org/C_C++/socket.htm */

#include <stdio.h>			/*input and output and is typically included in all C programs*/
#include <stdlib.h>			/*includes functions involving memory allocation, process control, conversions and others*/
#include <unistd.h>			/*provides access to operating system API*/
#include <string.h>			/*contains macro definitions, constants, and declarations of functions and types used not only for string handling but also various memory handling functions*/
#include <sys/types.h>		/*a number of data types used in system calls. These types are used in the next two include files*/
#include <sys/socket.h>		/*The header file socket.h includes a number of definitions of structures needed for sockets*/
#include <sys/signal.h>		/*System defined signals*/
#include <netinet/in.h>		/*contains constants and structures needed for internet domain addresses*/
#include <netdb.h>			/*definitions for network database operations*/
#include <time.h>			/* This header file contains definitions of functions to get and manipulate date and time information.*/

void CHECKsvr(int id);										/* function prototype */
int	 CHOSEsvr(char file[64]);								/* function prototype */
void ctrlstuff(int sock, char cmds[64], char file[64]);		/* function prototype */
void reaper(int sig)										//register interupt signal with function "reaper"
{	printf("\nMeta-server crashes!\n");
	remove("meta_a"); remove("meta_b");
	remove("meta_1"); remove("meta_2"); remove("meta_3"); remove("meta_4");
	exit(0);	}
void error(const char *msg)									// This function is called when a system call fails
{	perror(msg);											// It displays a message about the error on stderr and then aborts the program
	return;	}

int main(int argc, char *argv[])
{    socklen_t clilen;
     int sockfd, newsockfd, pid, portno = 6659;												/**MetaServer = 6659!!!**/
     struct sockaddr_in serv_addr, cli_addr;
	 char cmds[64], file[64];																// status[i][64], i=# of clients
	 int i, j;
	 FILE *fp;
	 
	 fp=fopen("meta_a","w"); fclose(fp); 
	 fp=fopen("meta_b","w"); fclose(fp);
	 CHECKsvr(1); CHECKsvr(2); CHECKsvr(3); CHECKsvr(4);
	 (void)signal(SIGINT,reaper);
	 
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
     } close(sockfd);                            											/* end of while, while(0) */
     return 0;                                   											/* we never get here */
}

/***------------------------------ ctrlstuff() ------------------------------
 There is a separate instance of this function for each connection.
 It handles all communication once a connnection has been established.
 ---------------------------------------------------------------------------***/
void ctrlstuff(int sock, char cmds[64], char file[64])					
{  int n, h, k, flag=0;
   int a, i, j, s;
   char hostinfo[27], hostinfo1[9], hostinfo2[9], hostinfo3[9], hostinfo4[9];
   char status[2][64], metafile[2][7];														// status[i][64], i=# of clients.  
   char GP;                                               					    			// GP = 0: GRANT, 1: Read protected, 2: Write protected.
   FILE *fp;
   time_t t;
   
	 bzero(status,2*64); bzero(metafile,2*7);
	 strcpy(metafile[0],"meta_a"); strcpy(metafile[1],"meta_b");
	 h = (int)(cmds[5])-97; k = (h+1)%2;													// a: h0/k1, b: h1/k0
	 strcpy(hostinfo1,"6661net31");	strcpy(hostinfo2,"6662net32");							/**CHANGE MACHINE No. & NAME!!!**/
	 strcpy(hostinfo3,"6663net33"); strcpy(hostinfo4,"6664net34");							/**CHANGE MACHINE No. & NAME!!!**/

     for (i = 0; i < 2; i++){
	 fp=fopen(metafile[i],"r");
		for(j = 0; j < 64; j++){
           fscanf(fp,"%c",&status[i][j]); 
           if (status[i][j] == EOF) break;}
	 }fclose(fp);
	 
	if (cmds[0] != '4') {															   		// client check status of a file
		   if (strcmp(&status[k][2],file)==0) GP = status[k][0];							// GP - 0: closed; 1: R_open; 2: W_open, 3:In_tran.
		   else GP = '0';

		 if (GP=='2') {
			write(sock,"2",1);}																// Write-any conflict
		 else if ((GP=='1') && ((cmds[0]=='3')||(cmds[0]=='5'))) {							// Read-Write,  Read-Off_load conflict
			write(sock,"1",1);}
		 else {																				// Most likely GP = 0: closed
			memcpy(&status[h][2],file,62); status[h][1] = '\t'; status[h][0] = cmds[0]-1;
			s = CHOSEsvr(file);
			
			if (cmds[0] == '5')	{															// off-load
				switch(s) {case 1: write(sock,"0",1); write(sock,hostinfo1,9); break;
						   case 2: write(sock,"0",1); write(sock,hostinfo2,9); break;
						   case 3: write(sock,"0",1); write(sock,hostinfo3,9); break;
						   case 4: write(sock,"0",1); write(sock,hostinfo4,9); break;
						   default: break;}
			}
			else {																			// create, read, or write
				switch(s) {case 1: memcpy(&hostinfo[0],hostinfo2,9); memcpy(&hostinfo[9],hostinfo3,9); memcpy(&hostinfo[18],hostinfo4,9); break;
						   case 2: memcpy(&hostinfo[0],hostinfo3,9); memcpy(&hostinfo[9],hostinfo4,9); memcpy(&hostinfo[18],hostinfo1,9); break;
						   case 3: memcpy(&hostinfo[0],hostinfo4,9); memcpy(&hostinfo[9],hostinfo1,9); memcpy(&hostinfo[18],hostinfo2,9); break;
						   case 4: memcpy(&hostinfo[0],hostinfo1,9); memcpy(&hostinfo[9],hostinfo2,9); memcpy(&hostinfo[18],hostinfo3,9); break;
						   default: break;}		
				write(sock,"0",1); write(sock,hostinfo,27);
			
			}
		 }
	}
	else if (cmds[0] == '4') {																// close a file, check servers, and then create metadata
		if ((h==0)||(h==1)) status[h][0] = '0';
		CHECKsvr(1); CHECKsvr(2); CHECKsvr(3); CHECKsvr(4);
	}
	printf("\nClients' status:\n");
	printf("Client[%d]=%s\t",h,status[h]); printf("Client[%d]=%s\n",k,status[k]);

	if ((h==0)||(h==1)) {
		fp=fopen(metafile[h],"w");
		for(j = 0; j < 64; j++) fputc(status[h][j],fp);
		fclose(fp);
	}
}

/***------------------------------ CHECKsvr() ------------------------------
						Check the status of servers' files
 ---------------------------------------------------------------------------***/
void CHECKsvr(int id)
{   int portno, sockfd, n, i;
    struct sockaddr_in serv_addr;
    struct hostent *server;
    char hostname[5], info[18], str[8][64], meta[1024];
	FILE *fp;
	bzero(meta,1024); bzero(info,18);
	bzero(str,8*64); str[0][0]='4';
	
	switch(id) {case 1: strcpy(hostname,"net31"); portno=6661; break;							/**CHANGE MACHINE No. & NAME!!!**/
				case 2: strcpy(hostname,"net32"); portno=6662; break;							/**CHANGE MACHINE No. & NAME!!!**/
				case 3: strcpy(hostname,"net33"); portno=6663; break;							/**CHANGE MACHINE No. & NAME!!!**/
				case 4: strcpy(hostname,"net34"); portno=6664; break;							/**CHANGE MACHINE No. & NAME!!!**/
				default: break;}
		
	sockfd = socket(AF_INET, SOCK_STREAM, 0);
    if (sockfd < 0) return;
    server = gethostbyname(hostname);
    if (server == NULL) return;
    bzero((char *) &serv_addr, sizeof(serv_addr));
    serv_addr.sin_family = AF_INET;
    bcopy((char *)server->h_addr, (char *)&serv_addr.sin_addr.s_addr, server->h_length);
    serv_addr.sin_port = htons(portno);
    if (connect(sockfd,(struct sockaddr *) &serv_addr,sizeof(serv_addr)) < 0) return;
	n = write(sockfd,"M",1);  if (n <= 0) printf("Server-%d is in use!\n",id);
    n = write(sockfd,info,18);  if (n <= 0) printf("Server-%d is in use!\n",id);
    n = write(sockfd,str,8*64);  if (n <= 0) printf("Server-%d is in use!\n",id);
	n = read(sockfd,meta,1024);  if (n <= 0) printf("Server-%d is in use!\n",id);
    close(sockfd);
	
	switch(id) {case 1: fp=fopen("meta_1","w");
						for( i = 0; i < 1024; i++)               
						 {if(meta[i] != '\0') fputc(meta[i],fp);	else break;} break;
				case 2: fp=fopen("meta_2","w");
						for( i = 0; i < 1024; i++)               
						 {if(meta[i] != '\0') fputc(meta[i],fp);	else break;} break;
				case 3: fp=fopen("meta_3","w");
						for( i = 0; i < 1024; i++)               
						 {if(meta[i] != '\0') fputc(meta[i],fp);	else break;} break;
				case 4: fp=fopen("meta_4","w");
						for( i = 0; i < 1024; i++)               
						 {if(meta[i] != '\0') fputc(meta[i],fp);	else break;} break;	 
				default: break;}	 
	fclose(fp);
}

/***------------------------------ CHOSEsvr() ------------------------------
						Choose which servers to be accessed
 ---------------------------------------------------------------------------***/
int CHOSEsvr(char file[64])
{	char str[64], status[4], metaN[7];
	FILE *fp;
	time_t t;
	int z, j, k, flag=1;

	for( k = 0; k < 4; k++) { bzero(metaN,7);
		switch(k) { case 0: strcpy(metaN,"meta_1"); break;
					case 1: strcpy(metaN,"meta_2"); break;
					case 2: strcpy(metaN,"meta_3"); break;
					case 3: strcpy(metaN,"meta_4"); break;
					default: break; }
		if((fp = fopen(metaN,"r"))==NULL)	status[k] = '2';										// empty file, server not up yet
      	else { while (flag==1) {
				 bzero(str,64);
				  for(j = 0; j < 64; j++){
						fscanf(fp,"%c",&str[j]);
						 if (str[j] == '\n') {str[j]='\0'; break;}
						 else if (str[j] == '\0') {flag = 0; break;}}
				  if (strcmp(str,file)==0) flag = 2;}
				fclose(fp);
				if (flag == 0)  status[k] = '0';													// server doesn't have that file
				else if (flag == 2) status[k] = '1';												// server has the file
				flag=1; }
	}
	if (status[0]=='2') z = 1;
	else if (status[1]=='2') z = 2;
	else if (status[2]=='2') z = 3;
	else if (status[3]=='2') z = 4;
	else if ((status[0]=='0')&&(status[1]=='0')&&(status[2]=='0')&&(status[3]=='0'))
	 { srand((unsigned) time(&t)); z = rand()%4+1; }												// when 4 servers are up and none of them has the file, random select three
	else if ((status[0]=='1')&&(status[1]=='1')&&(status[2]=='1')&&(status[3]=='1'))
	 { srand((unsigned) time(&t)); z = rand()%4+1; }
	else { for(k=3; k>-1; k--){
			if (status[k]=='0') { z = k+1; break; }
		} 
	}
	return (z);
}
