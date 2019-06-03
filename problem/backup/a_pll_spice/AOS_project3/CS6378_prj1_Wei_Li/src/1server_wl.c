/* A simple server in the internet domain using TCP.  The port number is passed as an argument */
/* Acknowledgement: http://www.linuxhowtos.org/C_C++/socket.htm */

#include <stdio.h>
#include <stdlib.h>  /* includes functions involving memory allocation, process control, conversions and others */
#include <string.h>  /* contains macro definitions, constants, and declarations of functions and types */
#include <unistd.h>  /* provides access to operating system API */
#include <sys/types.h>   /*a number of data types used in system calls. These types are used in the next two include files*/
#include <sys/socket.h>  /*The header file socket.h includes a number of definitions of structures needed for sockets*/     
#include <netinet/in.h>  /*contains constants and structures needed for internet domain addresses*/                         

void dostuff(int); /* function prototype */
void error(const char *msg)
{perror(msg);                                          // This function is called when a system call fails.                           
 exit(1);}                                             // It displays a message about the error on stderr and then aborts the program.

int main(int argc, char *argv[])
{
     int sockfd, newsockfd, pid, portno = 6658;                                           //CHANGE PORT NUMBER!!!
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


/***--------------- DOSTUFF() ------------------------------
 There is a separate instance of this function for each connection.
 It handles all communication once a connnection has been established.
 ------------------------------------------------------------***/
void dostuff (int sock)
{  int n,i,j,flag=0;
	 FILE *fp;
	 char str[8][64], docs[16][64];
	 
	 bzero(str,8*64); bzero(docs,16*64);
	 	 
	 n = read(sock,str,8*64);
   if (n < 0) error("ERROR reading from socket");
   
   switch(str[0][0])
     {case '1': if((fp=fopen(str[1],"r"))!=NULL)                  // starting from [1]
                  {n = write(sock,"File exists at net11!\n",32);                          //CHANGE MACHINE NAME!!!
                   if (n < 0) error("ERROR writing to socket");}  
                else {fp=fopen(str[1],"w");                       
                  	  for( i = 2; i < 8; i++){                    
                  	   if(flag == 1){break;}	                    
                       for( j = 0; j < 63; j++){                  
                       	if(str[i][j] != '^'){                     
                           fputc(str[i][j],fp);}                  //fprintf(fp,"%c",str[i][j]);}
                        else if (str[i][j] == '^'){               
                        str[i][j]= '\0'; flag = 1; break;}}}      
                n = write(sock,"File created at net11!\n",32);                            //CHANGE MACHINE NAME!!!
                if (n < 0) error("ERROR writing to socket");}
                fclose(fp);
     	          break;	 
     	                       
      case '2': if((fp=fopen(str[1],"r"))==NULL)  // starting from [1]   
      	          {n = write(sock,"Cannot find that file at net11!\n",64);                //CHANGE MACHINE NAME!!!
                   if (n < 0) error("ERROR writing to socket");}
      	        else {for( i = 0; i < 16; i++){                             
      	               for( j = 0; j < 63; j++){                            
      	                   fscanf(fp,"%c",&docs[i][j]);}}
      	              n = write(sock,docs,16*64);
      	              if (n < 0) error("ERROR writing to socket"); }                                                 
      	      	fclose(fp);   
                break;       
                
      case '3': if((fp=fopen(str[1],"r"))==NULL)
                   {n = write(sock,"Cannot write to a non-exiting file at net11!\n",64);  //CHANGE MACHINE NAME!!!
                    if (n < 0) error("ERROR writing to socket");}
                else {fp=fopen(str[1],"a");
                      for( i = 2; i < 8; i++){
                      	if(flag == 1){break;}
                        for( j = 0; j < 63; j++){ 
                       	 if(str[i][j] != '^'){
                           fputc(str[i][j],fp);}
                         else if (str[i][j] == '^'){
                           str[i][j]= '\0'; flag = 1;break;}}}
                n = write(sock,"File content added at net11!\n",64);                      //CHANGE MACHINE NAME!!!
                if (n < 0) error("ERROR writing to socket");}
                fclose(fp);            	
                break;  	               	          
      default:  break;
     }   
}
