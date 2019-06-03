/* Acknowledgement: http://www.linuxhowtos.org/C_C++/socket.htm */

#include <stdio.h>   /*input and output and is typically included in all C programs*/
#include <stdlib.h>  /*includes functions involving memory allocation, process control, conversions and others*/
#include <unistd.h>  /*provides access to operating system API*/
#include <string.h>  /*contains macro definitions, constants, and declarations of functions and types used not only for string handling but also various memory handling functions*/
#include <sys/types.h>   /*a number of data types used in system calls. These types are used in the next two include files*/
#include <sys/socket.h>  /*The header file socket.h includes a number of definitions of structures needed for sockets*/
#include <netinet/in.h>  /*contains constants and structures needed for internet domain addresses*/
#include <netdb.h>       /*definitions for network database operations*/
                                                 
void Wserver(char hostname[], int portno, char str[8][64]);
void Rserver(char hostname[], int portno, char str[8][64], char docs[16][64]);
void error(const char *msg)
{perror(msg);                                                          // This function is called when a system call fails.
exit(0);}                                                              // It displays a message about the error on stderr and then aborts the program.   

int main(int argc, char *argv[])
{   int sockfd, n, i, j, flag;
    int portno1, portno2, portno3;
    struct sockaddr_in serv_addr;
    struct hostent *server;
    char hostname2[5], hostname3[5];
    char dialog[64], str[8][64], docs[16][64];
    
    if (argc < 3) {
       fprintf(stderr,"usage %s hostname port\n", argv[0]);
       exit(0);}
    portno1 = atoi(argv[2]);
    //portno1 =6662;
    
    if (portno1==6658) {strcpy(hostname2,"net12"); portno2=6660;
    	                  strcpy(hostname3,"net13"); portno3=6662;}
    else if (portno1==6660) {strcpy(hostname2,"net13"); portno2=6662; 
    	                       strcpy(hostname3,"net11"); portno3=6658;}
    else if (portno1==6662) {strcpy(hostname2,"net11"); portno2=6658; 
    	                       strcpy(hostname3,"net12"); portno3=6660;}
    
    sockfd = socket(AF_INET, SOCK_STREAM, 0);
    if (sockfd < 0) 
        error("ERROR opening socket");
    server = gethostbyname(argv[1]);
    if (server == NULL) {
        fprintf(stderr,"ERROR, no such host\n");
        exit(0);
    }
    bzero((char *) &serv_addr, sizeof(serv_addr));
    serv_addr.sin_family = AF_INET;
    bcopy((char *)server->h_addr, 
         (char *)&serv_addr.sin_addr.s_addr,
         server->h_length);
    serv_addr.sin_port = htons(portno1);
    if (connect(sockfd,(struct sockaddr *) &serv_addr,sizeof(serv_addr)) < 0) 
        error("ERROR connecting");
    

    printf("1. Create a file\n2. Read a file\n3. Write to EOF\n\n");
    printf("Please enter your command (1 to 3): ");    
    bzero(str,8*64);
    bzero(docs,16*64);
    scanf("%c",&str[0][0]);
        	
    switch(str[0][0])
     {case '1': printf("Pls create a file name:\n");
                scanf("%s", &str[1]); getchar();
                printf("Creating new file\nPls enter file content (end with '^'):\n");
                for(i =2; i<8; i++){
                   flag = 0;
                   for(j =0; j<64; j++){
                     if((str[i][j]=getchar()) == '^'){
                       flag = 1;break;}} 
                   if(flag == 1){break;}}
                n = write(sockfd,str,8*64);
                 if (n < 0) error("ERROR writing to socket");
                n = read(sockfd,dialog,64);
                 if (n < 0) error("ERROR reading from socket");
                printf("%s\n",dialog);
                close(sockfd);
                Wserver(hostname2, portno2, str);                 // write to the other two servers
                Wserver(hostname3, portno3, str);                 // write to the other two servers
                break;
                
      case '2': printf("Pls enter a file name to read:\n");
                scanf("%s", &str[1]); getchar();
                bzero(docs,16*64);  
                n = write(sockfd,str,8*64);
                 if (n < 0) error("ERROR writing to socket");                
                n = read(sockfd,docs,16*64);
                 if (n < 0) error("ERROR reading from socket");
                for (i=0; i<16; i++){
                printf("%s",docs[i]);}
                printf("\n");
                close(sockfd);
                Rserver(hostname2, portno2, str, docs);                 // Check the other two servers' consistency
                Rserver(hostname3, portno3, str, docs);                 // Check the other two servers' consistency
                break;
                
      case '3': printf("Pls enter a file name to write:\n");                                   
      	        scanf("%s", &str[1]);
      	        printf("Input some new content at EOF (end with '^'):\n"); 
      	        for(i =2; i<8; i++){                                                   
      	           flag = 0;                                                           
      	           for(j =0; j<64; j++){                                               
      	             if((str[i][j]=getchar()) == '^'){                   
      	               flag = 1;break;}}                                               
      	           if(flag == 1){break;}}   
      	        n = write(sockfd,str,8*64);                                            
      	         if (n < 0) error("ERROR writing to socket");                          
      	        n = read(sockfd,dialog,64);                                            
      	         if (n < 0) error("ERROR reading from socket");                         
      	        printf("%s\n",dialog);
                close(sockfd);
                Wserver(hostname2, portno2, str);
                Wserver(hostname3, portno3, str);
                break;
      default: printf("Error: This is not a valid command!\n");
     }    //close(sockfd);
  return 0;
}
  	

void Wserver(char hostname[], int portno, char str[8][64])            // int main(int argc, char *argv[])
{   char dialog[64];
	  int sockfd, n;
    struct sockaddr_in serv_addr;
    struct hostent *server;
    
    sockfd = socket(AF_INET, SOCK_STREAM, 0);
    if (sockfd < 0) {error("ERROR opening socket");}                               // printf("ERROR on talking to '%s %d'", hostname, portno);
    server = gethostbyname(hostname);
    if (server == NULL) {fprintf(stderr,"ERROR, no such host\n"); exit(0);}        // printf("ERROR on talking to '%s %d'", hostname, portno);
    bzero((char *) &serv_addr, sizeof(serv_addr));
    serv_addr.sin_family = AF_INET;
    bcopy((char *)server->h_addr, 
         (char *)&serv_addr.sin_addr.s_addr,
         server->h_length);
    serv_addr.sin_port = htons(portno);
    if (connect(sockfd,(struct sockaddr *) &serv_addr,sizeof(serv_addr)) < 0) 
        {error("ERROR connecting");}                                               // printf("ERROR on talking to '%s %d'", hostname, portno);

    n = write(sockfd,str,8*64);
    if (n < 0) {printf("ERROR on talking to '%s %d'", hostname, portno);}                 // error("ERROR reading from socket");
    n = read(sockfd,dialog,64);
    if (n < 0) {printf("ERROR on talking to '%s %d'", hostname, portno);}                 // error("ERROR reading from socket");
    printf("%s\n",dialog);
    close(sockfd);
    }

void Rserver(char hostname[], int portno, char str[8][64], char docs[16][64])            // int main(int argc, char *argv[])
{   char docr[16][64];
	  int sockfd, n, i, j, flag=0;
    int portno1, portno2, portno3;
    struct sockaddr_in serv_addr;
    struct hostent *server;
    
    bzero(docr,16*64);
    
    sockfd = socket(AF_INET, SOCK_STREAM, 0);
    if (sockfd < 0) {error("ERROR opening socket");}                               // printf("ERROR on talking to '%s %d'", hostname, portno);
    server = gethostbyname(hostname);
    if (server == NULL) {fprintf(stderr,"ERROR, no such host\n"); exit(0);}        // printf("ERROR on talking to '%s %d'", hostname, portno);
    bzero((char *) &serv_addr, sizeof(serv_addr));
    serv_addr.sin_family = AF_INET;
    bcopy((char *)server->h_addr, 
         (char *)&serv_addr.sin_addr.s_addr,
         server->h_length);
    serv_addr.sin_port = htons(portno);
    if (connect(sockfd,(struct sockaddr *) &serv_addr,sizeof(serv_addr)) < 0) 
        {error("ERROR connecting");}                                               // printf("ERROR on talking to '%s %d'", hostname, portno);

    n = write(sockfd,str,8*64);
    if (n < 0) {printf("ERROR on talking to '%s %d'", hostname, portno);}                 // error("ERROR reading from socket");
    n = read(sockfd,docr,16*64);
    if (n < 0) {printf("ERROR on talking to '%s %d'", hostname, portno);}                 // error("ERROR reading from socket");
    
    
    for(i =0; i<8; i++){
       for(j =0; j<64; j++){
         if(docr[i][j] != docs[i][j]){                                 // printf("%c\n", docr[i][j]); printf("%c\n", docs[i][j]);
           printf("The file at %s is INconsistent.\n",hostname);
           flag = 1; break;}
         if (docr[i][j] == docs[i][j] == EOF) break;} 
       if(flag == 1){break;}}
    if(flag == 0) printf("The file at %s is Consistent.\n",hostname);
    close(sockfd);
    }
