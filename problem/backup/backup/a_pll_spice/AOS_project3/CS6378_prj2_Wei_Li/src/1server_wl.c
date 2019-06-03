/* A simple server in the internet domain using TCP.  The port number is passed as an argument */
/* Acknowledgement: http://www.linuxhowtos.org/C_C++/socket.htm */

#include <dirent.h>
#include <stdio.h>   /*input and output and is typically included in all C programs*/
#include <stdlib.h>  /*includes functions involving memory allocation, process control, conversions and others*/
#include <unistd.h>  /*provides access to operating system API*/
#include <string.h>  /*contains macro definitions, constants, and declarations of functions and types used not only for string handling but also various memory handling functions*/
#include <sys/types.h>   /*a number of data types used in system calls. These types are used in the next two include files*/
#include <sys/socket.h>  /*The header file socket.h includes a number of definitions of structures needed for sockets*/
#include <netinet/in.h>  /*contains constants and structures needed for internet domain addresses*/
#include <netdb.h>       /*definitions for network database operations*/

int CLSserver(char id);
int CWserver(char hostname[], int portno, char str[8][64]);
int Rserver(char hostname[], int portno, char str[8][64]);
void dostuff(int); /* function prototype */
void error(const char *msg)
{perror(msg);                                          // This function is called when a system call fails.                           
 exit(1);}                                             // It displays a message about the error on stderr and then aborts the program.

int main(int argc, char *argv[])
{    int sockfd, newsockfd, pid, portno = 6661;                                           /**CHANGE PORT NUMBER!!!**/
     socklen_t clilen;
     struct sockaddr_in serv_addr, cli_addr;
     
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
             dostuff(newsockfd);                 /* Excecute function */
             exit(0);}
         else close(newsockfd); 
     } close(sockfd);                            /* end of while, while(0) */
     return 0;                                   /* we never get here */
}


/***------------------------------ DOSTUFF() ------------------------------
 There is a separate instance of this function for each connection.
 It handles all communication once a connnection has been established.
 ---------------------------------------------------------------------------***/
void dostuff (int sock)
{  int n, i, j, k1=1, k2=1, flag=0;
     int a=1, b=2, c=3;													          /**CHANGE MACHINE #!!!**/
	 int portno1 = 6662, portno2 = 6663;                                          /**CHANGE PORT NUMBER!!!**/
	 char hostname1[5], hostname2[5];
	 char str[8][64], meta[16][32];
	 FILE *fp;
	 
	 strcpy(hostname1,"net12");	strcpy(hostname2,"net13");                        /**CHANGE MACHINE NAME!!!**/
	 bzero(str,8*64);
	 n = read(sock,&str[0][5],1);  if (n<=0) {CLSserver(str[0][5]); str[0][0]='0';} // must have n>0 here
	 n = read(sock,str,8*64);  if (n<=0) {CLSserver(str[0][5]); str[0][0]='0';}	  	 // detect client crash, inform M-server to close itself
   
   switch(str[0][0])
     {case '1': if((fp=fopen(str[1],"r"))!=NULL)                      // starting from [1], File exists, cannot create
                    {str[0][a]='2';}
                else {fp=fopen(str[1],"w");                       
                  	  for( i = 2; i < 8; i++){                    
                  	   if(flag == 1){break;}	                    
                       for( j = 0; j < 64; j++){                  
                       	if(str[i][j] != '^'){                     
                           fputc(str[i][j],fp);}                         // fprintf(fp,"%c",str[i][j]);}
                        else if (str[i][j] == '^'){               
                           fputc('\n',fp); flag = 1; break;}}}          // File created
					str[0][a]='1';}
	 
	            if (str[0][4] == '0'){str[0][4]='1'; 					 // str[0][4]=1, stop sending next time
				     k1 = CWserver(hostname1, portno1, str);              // write to the other 2 servers
					 str[0][b] = (char)(k1+48);
					 k2 = CWserver(hostname2, portno2, str);              // write to the other 2 servers
					 str[0][c] = (char)(k2+48);}				
				
				if (str[0][4] == '1'){                                  // requests propogation finish
				  printf("%c%c%c\n",str[0][1],str[0][2],str[0][3]);          // 0-DISconnect, 1-Success, 2-Fail
				  //if ((str[0][1]!='1')|(str[0][2]!='1')|(str[0][3]!='1'))    //{remove(str[1]);} 
				  n = write(sock,str[0],64); if (n < 0) error("ERROR writing to socket");
				  fclose(fp);}
                break;
				
      case '2': if((fp=fopen(str[1],"r"))==NULL)                        // starting from [1]   
      	           {str[0][a]='2';}
      	        else {for(i = 2; i < 8; i++){                    
                  	   if(flag == 1){break;}	                    
                       for(j = 0; j < 64; j++){
                           fscanf(fp,"%c",&str[i][j]); 
                       	   if (str[i][j] == EOF){flag = 1; break;}}}
					  str[0][a]='1';}                                                 
      	      	
	            if (str[0][4] == '0') {str[0][4]='1'; 					 // str[0][4]=1, stop sending next time
				     k1 = Rserver(hostname1, portno1, str);              // read the other 2 servers
					 str[0][b] = (char)(k1+48);
					 k2 = Rserver(hostname2, portno2, str);              // read the other 2 servers
					 str[0][c] = (char)(k2+48);}					
				
				if (str[0][4] == '1'){                                  // requests propogation finish
				  printf("%c%c%c\n",str[0][1],str[0][2],str[0][3]);          // 0-DISconnect, 1-Consistent, 2-NONexisting, 3-INconsistent
				  n = write(sock,str,8*64);  if (n < 0) error("ERROR writing to socket"); 
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
                           fputc('\n',fp); flag = 1; break;}}}          // Content added
					str[0][a]='1';}
				
				if (str[0][4] == '0'){str[0][4]='1'; 					 // str[0][4]=1, stop sending next time
				     k1 = CWserver(hostname1, portno1, str);              // write to the other 2 servers
					 str[0][b] = (char)(k1+48);
					 k2 = CWserver(hostname2, portno2, str);              // write to the other 2 servers
					 str[0][c] = (char)(k2+48);}				
				
				if (str[0][4] == '1'){                                  // requests propogation finish
				  printf("%c%c%c\n",str[0][1],str[0][2],str[0][3]);          // 0-DISconnect, 1-Success, 2-Fail
				  n = write(sock,str[0],64); if (n < 0) error("ERROR writing to socket");
				  fclose(fp);}         	
                break;

	  case '4': // search all files and make metadata
				bzero(meta,16*32);
				struct dirent* ent = NULL;			// this struct has "d_reclen", "d_type", and "d_name"
				DIR *pDir;
				char buf[1024];
				getcwd(buf,1024);
				pDir=opendir(buf);

				for (i=-2;i<16;i++){
				if (NULL != (ent=readdir(pDir))) {
				 if (ent->d_reclen!=16)	{
				  if (ent->d_type==8) strcpy(meta[i],ent->d_name);}}
				else break;}
				n = write(sock,meta,16*32); if (n < 0) error("ERROR writing to socket");
                break;			
      default:  break;
     }   
}

/***--------------------CWserver--------------------***/
int CWserver(char hostname[], int portno, char str[8][64])            // int main(int argc, char *argv[])
{   int sockfd, n, k=1;
    struct sockaddr_in serv_addr;
    struct hostent *server;
    
    sockfd = socket(AF_INET, SOCK_STREAM, 0);
    if (sockfd < 0) {k=0;}
    server = gethostbyname(hostname);
    if (server == NULL) {k=0;}                                       //fprintf(stderr,"ERROR, no such host\n"); 
    bzero((char *) &serv_addr, sizeof(serv_addr));
    serv_addr.sin_family = AF_INET;
    bcopy((char *)server->h_addr, 
         (char *)&serv_addr.sin_addr.s_addr,
         server->h_length);
    serv_addr.sin_port = htons(portno);
    if (connect(sockfd,(struct sockaddr *) &serv_addr,sizeof(serv_addr)) < 0) {k=0;}
    n = write(sockfd,"s",1);  if (n<=0) {k=0;}	
    n = write(sockfd,str,8*64);  if (n<=0) {k=0;}
	n = read(sockfd,str[0],64);  if (n<=0) {k=0;}
    close(sockfd);
	if ((portno==6661)&&(str[0][1]=='2')) {k=2;}                     // 0-DISconnect, 1-Success, 2-Fail
	else if ((portno==6662)&&(str[0][2]=='2')) {k=2;}
	else if ((portno==6663)&&(str[0][3]=='2')) {k=2;}
	return (k);
    }

/***--------------------Rserver--------------------***/
int Rserver(char hostname[], int portno, char str[8][64])            // int main(int argc, char *argv[])
{   int sockfd, n, i, j, k=1;
    char doc[8][64];
    struct sockaddr_in serv_addr;
    struct hostent *server;
    
    sockfd = socket(AF_INET, SOCK_STREAM, 0);
    if (sockfd < 0) {k=0;}
    server = gethostbyname(hostname);
    if (server == NULL) {k=0;}                                       //fprintf(stderr,"ERROR, no such host\n"); 
    bzero((char *) &serv_addr, sizeof(serv_addr));
    serv_addr.sin_family = AF_INET;
    bcopy((char *)server->h_addr, 
         (char *)&serv_addr.sin_addr.s_addr,
         server->h_length);
    serv_addr.sin_port = htons(portno);
    if (connect(sockfd,(struct sockaddr *) &serv_addr,sizeof(serv_addr)) < 0) {k=0;}
	bzero(doc,8*64);
    n = write(sockfd,"s",1);  if (n<=0) {k=0;}	
    n = write(sockfd,str,8*64);  if (n<=0) {k=0;}
	n = read(sockfd,doc,8*64);  if (n<=0) {k=0;}
    close(sockfd);
	if ((portno==6661)&&(doc[0][1]=='2')) {k=2;}					  // 0-DISconnect, 1-Consistent, 2-NONexisting, 3-INconsistent
	else if ((portno==6662)&&(doc[0][2]=='2')) {k=2;}
	else if ((portno==6663)&&(doc[0][3]=='2')) {k=2;}
	if (k==1) {
	  for(i = 2; i < 8; i++){
         for(j = 0; j < 64; j++){
           if(str[i][j] != doc[i][j]) {k=3; break;}	 			      // 0-DISconnect, 1-Consistent, 2-NONexisting, 3-INconsistent
           if ((str[i][j] == EOF)&&(doc[i][j] == EOF)) {break;}}
		 if(k==3) {break;}}}
	return (k);
    }

/***--------------------CLSserver--------------------***/
int CLSserver(char id)
{	int sockfd;
    struct sockaddr_in serv_addr;
    struct hostent *server;
    char str[2][64]; 
	
	bzero(str,2*64); str[0][0]='4'; str[0][5]=id;
	sockfd = socket(AF_INET, SOCK_STREAM, 0);
    if (sockfd < 0) 
        error("ERROR opening socket");
    server = gethostbyname("net19");                        /**M-server MACHINE NAME!!!**/
    if (server == NULL) {
        fprintf(stderr,"ERROR, no such host\n"); exit(0);}
    bzero((char *) &serv_addr, sizeof(serv_addr));
    serv_addr.sin_family = AF_INET;
    bcopy((char *)server->h_addr, 
         (char *)&serv_addr.sin_addr.s_addr,
         server->h_length);
    serv_addr.sin_port = htons(6659);						/**M-server PORT NUMBER!!!**/
    if (connect(sockfd,(struct sockaddr *) &serv_addr,sizeof(serv_addr)) < 0) 
        error("ERROR connecting");
	write(sockfd,str[0],64); write(sockfd,str[1],64);
    close(sockfd);
}
