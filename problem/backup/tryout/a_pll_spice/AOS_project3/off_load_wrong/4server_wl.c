/* A simple server in the internet domain using TCP.  The port number is passed as an argument */
/* Acknowledgement: http://www.linuxhowtos.org/C_C++/socket.htm */

#include <dirent.h>		/*defines the following data type through typedef*/	
#include <stdio.h>		/*input and output and is typically included in all C programs*/
#include <stdlib.h>		/*includes functions involving memory allocation, process control, conversions and others*/
#include <unistd.h>		/*provides access to operating system API*/
#include <string.h>		/*contains macro definitions, constants, and declarations of functions and types used not only for string handling but also various memory handling functions*/
#include <sys/types.h>	/*a number of data types used in system calls. These types are used in the next two include files*/
#include <sys/signal.h>	/*System defined signals*/
#include <sys/socket.h>	/*The header file socket.h includes a number of definitions of structures needed for sockets*/
#include <netinet/in.h>	/*contains constants and structures needed for internet domain addresses*/
#include <netdb.h>		/*definitions for network database operations*/

int CWserver(char hostname[5], char num, int portno, char str[8][64]);				/* create/write a file */
int Rserver(char hostname[5], char num, int portno, char str[8][64]);				/* read a file */
int CLSserver(char id, char hostnamem[5], int portnom);								/* close a file */
int OFLserver(char filename[64], char sid, char hostnamem[5], int portnom);			/* off-load */
void INTserver (char hostnamem[5], int portnom);									/* initial metadata */
void dostuff(int sock, char hostnamem[5], char portnom);							/* function prototype */
void error(const char *msg)															// This function is called when a system call fails.   
{perror(msg); exit(1);}																// It displays a message about the error on stderr and then aborts the program.

int main(int argc, char *argv[])
{    int sockfd, newsockfd, pid, OFL;
	 int portno = 6664;                                           					/**CHANGE PORT NUMBER!!!**/
	 char sid, filename[64];
     socklen_t clilen;
     struct sockaddr_in serv_addr, cli_addr;
	 char hostnamem[] = "net19";		int portnom = 6659;							/**M-server MACHINE NAME & PORT NUMBER!!!**/
	 
	 bzero(filename,64);
	 printf("Please choose the server No.(1-4) to offload a file.\n'0' to quit this and enter the normal file-server mode!\n"); scanf("%c", &sid);
	 if (sid != '0') {printf("Please enter a file name you want to off-load to this server:\n"); scanf("%s", filename); getchar();}
	 while (sid != '0') {
		 OFL = OFLserver(filename, sid, hostnamem, portnom);
			if ((OFL == 1) || (OFL == 2)) {
				if (OFL == 2) printf("This file exits here already, cannot be moved from another server again!\n");
				printf("Please choose anpther server No.(1-4) to offload a file.\n");
				printf("'0' to quit this and enter the normal file-server mode!\n"); scanf("%c", &sid);
				if (sid != '0') {printf("Please enter another file name you want to off-load to this server:\n"); scanf("%s", filename); getchar();}
			}
			else if (OFL == 0) { printf("Delay: This file is in R/W protection!\n"); sleep(3); }
		}
	 printf("Enter to normal file-server mode!\n");
	 INTserver(hostnamem, portnom);
	 
     sockfd = socket(AF_INET, SOCK_STREAM, 0);
     if (sockfd < 0)
        error("ERROR opening socket");
     bzero((char *) &serv_addr, sizeof(serv_addr));
     serv_addr.sin_family = AF_INET;
     serv_addr.sin_addr.s_addr = INADDR_ANY;
     serv_addr.sin_port = htons(portno);
     if (bind(sockfd, (struct sockaddr *) &serv_addr,
              sizeof(serv_addr)) < 0) 
              error("ERROR on binding");
     listen(sockfd,5);
     clilen = sizeof(cli_addr);
     while (1) {
         newsockfd = accept(sockfd, 
               (struct sockaddr *) &cli_addr, &clilen);
         if (newsockfd < 0) 
             error("ERROR on accept");
         pid = fork();
         if (pid < 0)
             error("ERROR on fork");
         if (pid == 0)  {
             close(sockfd);
             dostuff(newsockfd, hostnamem, portnom);								/* Excecute function */
             exit(0);}
         else close(newsockfd); 
     } close(sockfd);																/* end of while, while(0) */
     return 0;																		/* we never get here */
}


/***------------------------------ DOSTUFF() ------------------------------
 There is a separate instance of this function for each connection.
 It handles all communication once a connnection has been established.
 ---------------------------------------------------------------------------***/
void dostuff (int sock, char hostnamem[5], char portnom)
{  int n, i, j, k1=1, k2=1, flag=0;
     int a, b, c;
	 int portno1, portno2;
	 char info[18], hostname1[6], hostname2[6];
	 char str[8][64], meta[1024];
	 FILE *fp;

	 bzero(str,8*64); bzero(hostname1,6); bzero(hostname2,6);
	 n = read(sock,&str[0][5],1);
		if (n<=0) {CLSserver(str[0][5], hostnamem, portnom); str[0][0]='0';}				// must have n>0 here
	 n = read(sock,info,18);
		if (n<=0) {CLSserver(str[0][5], hostnamem, portnom); str[0][0]='0';}				// must have n>0 here
	 n = read(sock,str,8*64);
		if (n<=0) {CLSserver(str[0][5], hostnamem, portnom); str[0][0]='0';}				// detect client crash, inform M-server to close itself
	 
	 portno1 = ((int)(info[0]-48))*1000 + ((int)(info[1]-48)*100) + ((int)(info[2]-48))*10 + (int)(info[3]-48);
	 memcpy(hostname1,&info[4],5);
	 portno2 = ((int)(info[9]-48))*1000 + ((int)(info[10]-48)*100) + ((int)(info[11]-48))*10 + (int)(info[12]-48);
	 memcpy(hostname2,&info[13],5);
	 switch(str[0][5]) { case '2': a = 2; b = 3; c = 1; break;
						 case '3': a = 3; b = 1; c = 2; break;
						 default:  a = 1; b = 2; c = 3; break;								// str[0][5] == 'a' or 'b'
						}
printf("rest TWO servers are %s %d - %s %d, and operation is '%c'!\n", hostname1, portno1, hostname2, portno2, str[0][0]);
   switch(str[0][0])
     {case '1': if((fp=fopen(str[1],"r"))!=NULL)											// starting from [1], File exists, cannot create
                    {str[0][a]='2';}
                else {fp=fopen(str[1],"w");
                  	  for( i = 2; i < 8; i++){
                  	   if(flag == 1){break;}
                       for( j = 0; j < 64; j++){
                       	if(str[i][j] != '^'){
                           fputc(str[i][j],fp);}											// fprintf(fp,"%c",str[i][j]);}
                        else if (str[i][j] == '^'){
                           fputc('\n',fp); flag = 1; break;}}}								// File created
					str[0][a]='1';}
printf("Status: %s %s!\n", str[0], str[1]);
	            if (str[0][4] == '0'){str[0][4]='1';										// str[0][4]=1, stop sending next time
				     k1 = CWserver(hostname1, '2', portno1, str);							// write to the other 2 servers
					 str[0][b] = (char)(k1+48);
					 k2 = CWserver(hostname2, '3', portno2, str);							// write to the other 2 servers
					 str[0][c] = (char)(k2+48);}

				if (str[0][4] == '1'){														// requests propogation finish
printf("%c%c%c\n",str[0][1],str[0][2],str[0][3]);	// 0-DISconnect, 1-Success, 2-Fail
				  n = write(sock,str[0],64); if (n < 0) return;
				  fclose(fp);}
                break;

      case '2': if((fp=fopen(str[1],"r"))==NULL)                        					// starting from [1]   
      	           {str[0][a]='2';}
      	        else {for(i = 2; i < 8; i++){
                  	   if(flag == 1){break;}
                       for(j = 0; j < 64; j++){
                           fscanf(fp,"%c",&str[i][j]);
                       	   if (str[i][j] == EOF){flag = 1; break;}}}
					  str[0][a]='1';}

	            if (str[0][4] == '0') {str[0][4]='1';										// str[0][4]=1, stop sending next time
				     k1 = Rserver(hostname1, '2', portno1, str);							// read the other 2 servers
					 str[0][b] = (char)(k1+48);
					 k2 = Rserver(hostname2, '3', portno2, str);							// read the other 2 servers
					 str[0][c] = (char)(k2+48);}					

				if (str[0][4] == '1'){														// requests propogation finish
printf("%c%c%c\n",str[0][1],str[0][2],str[0][3]);	// 0-DISconnect, 1-Consistent, 2-NONexisting, 3-INconsistent
				  n = write(sock,str,8*64);  if (n < 0) return;
				fclose(fp);}
                break;

      case '3': if((fp=fopen(str[1],"r"))==NULL)
                   {str[0][a]='2';}
                else {fp=fopen(str[1],"a");
                      for( i = 2; i < 8; i++){
                      	if(flag == 1){break;}
                        for( j = 0; j < 64; j++){
                       	 if(str[i][j] != '^'){
                           fputc(str[i][j],fp);}
                         else if (str[i][j] == '^'){
                           fputc('\n',fp); flag = 1; break;}}}								// Content added
					str[0][a]='1';}

				if (str[0][4] == '0'){str[0][4]='1';										// str[0][4]=1, stop sending next time
				     k1 = CWserver(hostname1, '2', portno1, str);							// write to the other 2 servers
					 str[0][b] = (char)(k1+48);
					 k2 = CWserver(hostname2, '3', portno2, str);							// write to the other 2 servers
					 str[0][c] = (char)(k2+48);}
				
				if (str[0][4] == '1'){														// requests propogation finish
printf("%c%c%c\n",str[0][1],str[0][2],str[0][3]);	// 0-DISconnect, 1-Success, 2-Fail
				  n = write(sock,str[0],64); if (n < 0) return;
				  fclose(fp);}         	
                break;

	  case '4': bzero(meta,1024);															// search all files and make metadata
				struct dirent* ent = NULL;													// this struct has "d_reclen", "d_type", and "d_name"
				DIR *pDir;
				char buf[1024], enter[] = {'\n','\0'};
				getcwd(buf,1024);
				pDir=opendir(buf);

				while (NULL != (ent=readdir(pDir))) {
				 if (ent->d_reclen!=16)	{													// d_reclen: 16-child_directory (or starting with '.'), 24-binary_file, 28-non_child_directory
				  if (ent->d_type==8) {														// d_type: 4-directory, 8-file
				   strcat(meta,ent->d_name); 
				   strcat(meta,enter);}
				 }
				} n = write(sock,meta,1024); if (n < 0) return;
                break;

	  case '5': if((fp=fopen(str[1],"r"))==NULL)
      	           n = write(sock,"0",1); if (n < 0) return;
      	        else { printf("File '%s' will be removed locally.\n",str[1]);
					for(i = 2; i < 8; i++){ if(flag == 1) break;
                       for(j = 0; j < 64; j++){
                           fscanf(fp,"%c",&str[i][j]); 
                       	   if (str[i][j] == EOF) {flag = 1; break;}}
					} fclose(fp);
      	            n = write(sock,"1",1); if (n < 0) return;
					n = write(sock,str,8*64);  if (n < 0) return;
					remove(str[1]);
				}
      default:  break;
     }   
}

/***--------------------CWserver--------------------***/
int CWserver(char hostname[5], char num, int portno, char str[8][64])
{   char info[18]; bzero(info,18);
	int sockfd, n, k=1;
    struct sockaddr_in serv_addr;
    struct hostent *server;
    
	memcpy(&str[0][5],&num,1);
    sockfd = socket(AF_INET, SOCK_STREAM, 0);
    if (sockfd < 0) {k=0;}
    server = gethostbyname(hostname);
    if (server == NULL) {k=0;}																//fprintf(stderr,"ERROR, no such host\n"); 
    bzero((char *) &serv_addr, sizeof(serv_addr));
    serv_addr.sin_family = AF_INET;
    bcopy((char *)server->h_addr, 
         (char *)&serv_addr.sin_addr.s_addr,
         server->h_length);
    serv_addr.sin_port = htons(portno);
    if (connect(sockfd,(struct sockaddr *) &serv_addr,sizeof(serv_addr)) < 0) {k=0;}
	
	n = write(sockfd,&num,1);  if (n<=0) {k=0;}
	n = write(sockfd,info,18); if (n<=0) {k=0;}
    n = write(sockfd,str,8*64);  if (n<=0) {k=0;}
	n = read(sockfd,str[0],64);  if (n<=0) {k=0;}
    close(sockfd);
	if ((num=='2')&&(str[0][2]=='2')) {k=2;}												// 0-DISconnect, 1-Success, 2-Fail
	else if ((num=='3')&&(str[0][3]=='2')) {k=2;}
	return (k);
    }

/***--------------------Rserver--------------------***/
int Rserver(char hostname[5], char num, int portno, char str[8][64])
{   int sockfd, n, i, j, k=1;
    char doc[8][64], info[18]; bzero(info,18);
    struct sockaddr_in serv_addr;
    struct hostent *server;
    
	memcpy(&str[0][5],&num,1);	
    sockfd = socket(AF_INET, SOCK_STREAM, 0);
    if (sockfd < 0) {k=0;}
    server = gethostbyname(hostname);
    if (server == NULL) {k=0;}																// fprintf(stderr,"ERROR, no such host\n"); 
    bzero((char *) &serv_addr, sizeof(serv_addr));
    serv_addr.sin_family = AF_INET;
    bcopy((char *)server->h_addr, 
         (char *)&serv_addr.sin_addr.s_addr,
         server->h_length);
    serv_addr.sin_port = htons(portno);
    if (connect(sockfd,(struct sockaddr *) &serv_addr,sizeof(serv_addr)) < 0) {k=0;}
	
	bzero(doc,8*64);
    n = write(sockfd,&num,1);  if (n<=0) {k=0;}
	n = write(sockfd,info,18); if (n<=0) {k=0;}
    n = write(sockfd,str,8*64);  if (n<=0) {k=0;}
	n = read(sockfd,doc,8*64);  if (n<=0) {k=0;}
    close(sockfd);
	if ((num=='2')&&(doc[0][2]=='2')) {k=2;}												// 0-DISconnect, 1-Success, 2-Fail
	else if ((num=='3')&&(doc[0][3]=='2')) {k=2;}
	if (k==1) {
	  for(i = 2; i < 8; i++){
         for(j = 0; j < 64; j++){
           if(str[i][j] != doc[i][j]) {k=3; break;}											// 0-DISconnect, 1-Consistent, 2-NONexisting, 3-INconsistent
           if ((str[i][j] == EOF)&&(doc[i][j] == EOF)) {break;}}
		 if(k==3) break;}
	}
	return (k);
    }

/***--------------------CLSserver--------------------***/
int CLSserver(char id, char hostnamem[5], int portnom)
{	int sockfd;
    struct sockaddr_in serv_addr;
    struct hostent *server;
    char str[2][64]; 
	
	bzero(str,2*64); str[0][0]='4'; str[0][5]=id;
	sockfd = socket(AF_INET, SOCK_STREAM, 0);
    if (sockfd < 0) return;
    server = gethostbyname(hostnamem);
    if (server == NULL) return;
    bzero((char *) &serv_addr, sizeof(serv_addr));
    serv_addr.sin_family = AF_INET;
    bcopy((char *)server->h_addr, 
         (char *)&serv_addr.sin_addr.s_addr,
         server->h_length);
    serv_addr.sin_port = htons(portnom);
    if (connect(sockfd,(struct sockaddr *) &serv_addr,sizeof(serv_addr)) < 0) return;
	write(sockfd,str[0],64); write(sockfd,str[1],64);
    close(sockfd);
}

/***--------------------OFLserver--------------------***/
int OFLserver(char filename[64], char sid, char hostnamem[5], int portnom)
{   int sockfd, n, i, j, z, portno, flag=0;
    struct sockaddr_in serv_addr;
    struct hostent *server;
    char GR, RM, hostname[5], Sinfo3[27], Sinfo2[18], str[8][64];							// GR = 0: GRANT, 1: Read protected, 2: Write protected
	FILE *fp;

	if((fp=fopen(filename,"r"))!=NULL) { fclose(fp); z = 2; return (z);}
	
    bzero(str,8*64); bzero(Sinfo3,27); bzero(Sinfo2,18);
	str[0][0] = '5'; str[0][5] = 's';
	strcpy(str[1],filename);

    sockfd = socket(AF_INET, SOCK_STREAM, 0);
    if (sockfd < 0) return;
		server = gethostbyname(hostnamem);
    if (server == NULL) return;
    bzero((char *) &serv_addr, sizeof(serv_addr));
    serv_addr.sin_family = AF_INET;
    bcopy((char *)server->h_addr, (char *)&serv_addr.sin_addr.s_addr, server->h_length);
		serv_addr.sin_port = htons(portnom);
    if (connect(sockfd,(struct sockaddr *) &serv_addr,sizeof(serv_addr)) < 0) return;
	n = write(sockfd,str[0],64); if (n < 0) return;
	n = write(sockfd,str[1],64); if (n < 0) return;
	n = read(sockfd,&GR,1); if (n < 0) return;												// check status of file. 0: closed; 1: R_open; 2: W_open.

	if (GR =='1') {
		z = 0; close(sockfd); printf("REJECT: This file is in 'R_open' mode; please try this later!\n"); }
	else if (GR =='2') {
		z = 0; close(sockfd); printf("REJECT: This file is in 'W_open' mode; please try this later!\n"); }
	else if (GR =='0') {
		z = 1; printf("\nGRANT!\n");
		n = read(sockfd,Sinfo3,27); if (n < 0) return; close(sockfd);
		switch(sid) {case '1': strcpy(hostname,"net31"); portno=6661; break;				/**CHANGE Machine name & PORT NUMBER!!!**/
					 case '2': strcpy(hostname,"net32"); portno=6662; break;				/**CHANGE Machine name & PORT NUMBER!!!**/
					 case '3': strcpy(hostname,"net33"); portno=6663; break;				/**CHANGE Machine name & PORT NUMBER!!!**/
					 case '4': strcpy(hostname,"net34"); portno=6664; break;				/**CHANGE Machine name & PORT NUMBER!!!**/
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
		n = write(sockfd,&str[0][5],1); if (n < 0) return;
		n = write(sockfd,Sinfo2,18); if (n < 0) return;
		n = write(sockfd,str,8*64); if (n < 0) return;
		n = read(sockfd,&RM,1); if (n < 0) return;
		
		if ( RM == '0') printf("Fail to move '%s', because it does not exit in server-%c!\n", filename, sid);
		else if ( RM == '1') {
			n = read(sockfd,str,8*64); if (n < 0) return;
			fp=fopen(filename,"w");                       
			for( i = 2; i < 8; i++){ if(flag == 1) break;
				for( j = 0; j < 64; j++){                  
					if(str[i][j] != '\0') fputc(str[i][j],fp);
					else if (str[i][j] == '\0') { flag = 1; break; }
				}
			} fclose(fp);
			printf("File '%s' is moved here from server-%c!\n", filename, sid);
		}
		close(sockfd);
	}
	return (z);
}

/***--------------------INTserver--------------------***/
void INTserver (char hostnamem[5], int portnom)
{   int sockfd, n;
    struct sockaddr_in serv_addr;
    struct hostent *server;
    char str[2][64]; bzero(str,2*64);
	
	str[0][0]='4';
	sockfd = socket(AF_INET, SOCK_STREAM, 0);
    if (sockfd < 0) return;
    server = gethostbyname(hostnamem);
    if (server == NULL) return;
    bzero((char *) &serv_addr, sizeof(serv_addr));
    serv_addr.sin_family = AF_INET;
    bcopy((char *)server->h_addr, (char *)&serv_addr.sin_addr.s_addr, server->h_length);
    serv_addr.sin_port = htons(portnom);
    if (connect(sockfd,(struct sockaddr *) &serv_addr,sizeof(serv_addr)) < 0) return;
	n = write(sockfd,str[0],64);  if (n < 0) return;
	n = write(sockfd,str[1],64);  if (n < 0) return;
    close(sockfd);
}
