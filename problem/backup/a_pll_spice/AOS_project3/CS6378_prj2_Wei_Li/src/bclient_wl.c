/* Acknowledgement: http://www.linuxhowtos.org/C_C++/socket.htm */

#include <stdio.h>   /*input and output and is typically included in all C programs*/
#include <stdlib.h>  /*includes functions involving memory allocation, process control, conversions and others*/
#include <unistd.h>  /*provides access to operating system API*/
#include <string.h>  /*contains macro definitions, constants, and declarations of functions and types used not only for string handling but also various memory handling functions*/
#include <sys/types.h>   /*a number of data types used in system calls. These types are used in the next two include files*/
#include <sys/socket.h>  /*The header file socket.h includes a number of definitions of structures needed for sockets*/
#include <netinet/in.h>  /*contains constants and structures needed for internet domain addresses*/
#include <netdb.h>       /*definitions for network database operations*/
                                                 
void error(const char *msg)
{perror(msg);                                                          // This function is called when a system call fails.
exit(0);}                                                              // It displays a message about the error on stderr and then aborts the program.   

int main()															   // int main(int argc, char *argv[])
{   int sockfd, n, i, j, k, flag;
    int portnom, portnod;                                              // Port # of M-server and data-server
    struct sockaddr_in serv_addr;
    struct hostent *server;
    char GR, str[8][64];                                               // GR = 0: GRANT, 1: Read protected, 2: Write protected
	char hostnamem[5], hostnamed[5], hostinfo[9];                      // Port name of M-server and data-server
    
    //if (argc < 3) {fprintf(stderr,"usage %s hostname port\n", argv[0]); exit(0);} portno = atoi(argv[2]);
    portnom = 6659;           										    /**connect to M-server!!!**/
	strcpy(hostnamem,"net19");                                          /**M-server MACHINE NAME!!!**/
    
    bzero(str,8*64); bzero(hostinfo,9); str[0][4]='0';									   //str[0][1]='1';str[0][2]='1';str[0][3]='1';
	str[0][5] = 'b';																		/**Identity of the Client**/
    printf("1. Create a file\n2. Read a file\n3. Write to EOF\n\n");
    printf("Please enter your command (1 to 3): ");    
    scanf("%c",&str[0][0]);
	if ((str[0][0]!='1')&&(str[0][0]!='2')&&(str[0][0]!='3')) {printf("Error: This is not a valid command!\n"); exit(0);}
	printf("Please enter a file name you want to access: ");
    scanf("%s", str[1]); getchar();
	
    sockfd = socket(AF_INET, SOCK_STREAM, 0);
    if (sockfd < 0) error("ERROR opening socket"); //server = gethostbyname(argv[1]);
		server = gethostbyname(hostnamem);							   /*CHANGE host NAME!!!*/
    if (server == NULL) {fprintf(stderr,"ERROR, no such host\n"); exit(0);}
    bzero((char *) &serv_addr, sizeof(serv_addr));
    serv_addr.sin_family = AF_INET;
    bcopy((char *)server->h_addr, (char *)&serv_addr.sin_addr.s_addr, server->h_length);
    serv_addr.sin_port = htons(portnom);							   /*CHANGE portnoN!!!*/
    if (connect(sockfd,(struct sockaddr *) &serv_addr,sizeof(serv_addr)) < 0) error("ERROR connecting");
	n = write(sockfd,str[0],64); if (n < 0) error("ERROR writing to socket");
	n = write(sockfd,str[1],64); if (n < 0) error("ERROR writing to socket");
	n = read(sockfd,&GR,1); if (n < 0) error("ERROR reading from socket");          // check status of file. 0: closed; 1: R_open; 2: W_open.

	if (GR =='1') { close(sockfd); printf("REJECT: This file is in 'R_open' mode, and only be read now!\n"); exit(0);}
	else if (GR =='2') { close(sockfd); printf("REJECT: This file is in 'W_open' mode, and cannot be accessed now!\n"); exit(0);}
	else if (GR =='0') { n = read(sockfd,hostinfo,9); if (n < 0) error("ERROR reading from socket");
						 portnod = ((int)(hostinfo[0]-48))*1000 + ((int)(hostinfo[1]-48)*100) + ((int)(hostinfo[2]-48))*10 + (int)(hostinfo[3]-48);
						 memcpy(hostnamed,&hostinfo[4],5);
						 close(sockfd); printf("\nGRANT!\n");
						 printf("Client is accessing to server %s #%d.\n", hostnamed, portnod);
					 
	sockfd = socket(AF_INET, SOCK_STREAM, 0);
    if (sockfd < 0) error("ERROR opening socket");
		server = gethostbyname(hostnamed);							   /*CHANGE host NAME!!!*/
    if (server == NULL) {fprintf(stderr,"ERROR, no such host\n"); exit(0);}
    bzero((char *) &serv_addr, sizeof(serv_addr));
    serv_addr.sin_family = AF_INET;
    bcopy((char *)server->h_addr, (char *)&serv_addr.sin_addr.s_addr, server->h_length);
    serv_addr.sin_port = htons(portnod);							   /*CHANGE portnoN!!!*/
    if (connect(sockfd,(struct sockaddr *) &serv_addr,sizeof(serv_addr)) < 0) error("ERROR connecting");
	n = write(sockfd,&str[0][5],1); if (n < 0) error("ERROR writing to socket");	
    switch(str[0][0])
     {case '1': printf("Creating new file\nPls enter file content (end with '^'):\n");
                for(i =2; i<8; i++){
                   flag = 0;
                   for(j =0; j<64; j++){
                     if((str[i][j]=getchar()) == '^'){
                       flag = 1;break;}} 
                   if(flag == 1){break;}}
                n = write(sockfd,str,8*64); if (n < 0) error("ERROR writing to socket");
                n = read(sockfd,str[0],64); if (n < 0) error("ERROR reading from socket");
                close(sockfd);
                for (k=1; k<4; k++){
                  switch(str[0][k]) {
				    case '0': printf("Error on connecting to server%d!\n",k); break;
		            case '1': printf("File created at server%d!\n",k); break;
                    case '2': printf("File exists at server%d!\n",k); break;
                    default: break;}}    //printf("%c%c%c\n",str[0][1],str[0][2],str[0][3]);
				break;
                
      case '2': printf("Press any key and ENTER to read...\n"); getchar(); getchar();
				n = write(sockfd,str,8*64); if (n < 0) error("ERROR writing to socket");                
                n = read(sockfd,str,8*64); if (n < 0) error("ERROR reading from socket");
                close(sockfd);				//printf("%c%c%c\n",str[0][1],str[0][2],str[0][3]);
				
				if ((str[0][1]=='1')&&(str[0][2]=='1')&&(str[0][3]=='1')) {    // if (str[0][1]==str[0][2]==str[0][3]=='1') {
				 printf("\nThe file at is Consistent at all servers, and its content is:\n");
				   for(i =2; i<8; i++) { flag = 0;                             // WRONG: for (i=2; i<8; i++) {printf("%s",str[i]);}}
                   for(j =0; j<64; j++) { printf("%c",str[i][j]);
                     if(str[i][j] == EOF) {flag = 1;break;}} 
                   if(flag == 1){break;}}}
				else {
				  for (k=1; k<4; k++){
                  switch(str[0][k]) {
				    case '0': printf("Error on connecting to server%d!\n",k); break;
		            case '1': printf("File exists at server%d!\n",k); break;
                    case '2': printf("File does not exist at server%d!\n",k); break;
					case '3': printf("The file at server%d is INconsistent!\n",k); break;
                    default : break;}}}
                printf("\n");
                break;
                
      case '3': str[0][0]='2';
				n = write(sockfd,str,8*64); if (n < 0) error("ERROR writing to socket");                
                n = read(sockfd,str,8*64); if (n < 0) error("ERROR reading from socket");
                close(sockfd);
				//printf("CHECK%c%c%c\n",str[0][1],str[0][2],str[0][3]);                   // {printf("str[1]?:%s\n",str[1]);}	
				if ((str[0][1]=='2')||(str[0][2]=='2')||(str[0][3]=='2')) {
				  printf("This file cannot be found in (one or some) server(s)!\n",k); break;} 
				else if ((str[0][1]!='1')||(str[0][2]!='1')||(str[0][3]!='1')) {
                  printf("The file being accessed is INconsistent in servers!\n",k); break;}
				else {str[0][0]='3'; str[0][4]='0';
				      for(i =2; i<8; i++){bzero(str[i],64);}                            // for (i=0; i<8; i++) {printf("BZERO?:%s\n",str[i]);}
					
				sockfd = socket(AF_INET, SOCK_STREAM, 0);
				if (sockfd < 0) error("ERROR opening socket"); 
					server = gethostbyname(hostnamed);							   /*CHANGE host NAME!!!*/
				if (server == NULL) {fprintf(stderr,"ERROR, no such host\n"); exit(0);}
				bzero((char *) &serv_addr, sizeof(serv_addr));
				serv_addr.sin_family = AF_INET;
				bcopy((char *)server->h_addr, (char *)&serv_addr.sin_addr.s_addr, server->h_length);
				serv_addr.sin_port = htons(portnod);							   /*CHANGE portnoN!!!*/
				if (connect(sockfd,(struct sockaddr *) &serv_addr,sizeof(serv_addr)) < 0) error("ERROR connecting");
				n = write(sockfd,&str[0][5],1); if (n < 0) error("ERROR writing to socket");

				//(Checking consistency of copies in servers is highly recommended here, before writing to EOF)\n"); 
				printf("The file is Consistent in all copies.\nInput some new content at EOF (end with '^'):\n");
				for(i =2; i<8; i++){ flag = 0;                                                           
      	           for(j =0; j<64; j++){                                               
      	             if((str[i][j]=getchar()) == '^'){                   
      	               flag = 1;break;}}                                               
      	           if(flag == 1){break;}}                                               // for (i=0; i<8; i++) {printf("writnin?:%s\n",str[i]);}
      	        n = write(sockfd,str,8*64); if (n < 0) error("ERROR writing to socket");                          
      	        n = read(sockfd,str[0],64); if (n < 0) error("ERROR reading from socket"); 
                close(sockfd);
      	        printf("WRITE%c%c%c\n",str[0][1],str[0][2],str[0][3]);
				for (k=1; k<4; k++){
                  switch(str[0][k]) {
				    case '0': printf("Error on connecting to server%d!\n",k); break;
		            case '1': printf("New content added to EOF created at server%d!\n",k); break;
                    case '2': printf("File does not exists at server%d!\n",k); break;
                    default: break;}}    //printf("%c%c%c\n",str[0][1],str[0][2],str[0][3]);
				break;}
      default: printf("Error: This is not a valid command!\n"); break;
     }    //close(sockfd);

	str[0][0] = '4';												// inform M-server to close the file
	sockfd = socket(AF_INET, SOCK_STREAM, 0);
	if (sockfd < 0) error("ERROR opening socket");
	server = gethostbyname(hostnamem);							   	/*CHANGE host NAME!!!*/
	if (server == NULL) {fprintf(stderr,"ERROR, no such host\n"); exit(0);}
	bzero((char *) &serv_addr, sizeof(serv_addr));
	serv_addr.sin_family = AF_INET;
	bcopy((char *)server->h_addr, (char *)&serv_addr.sin_addr.s_addr, server->h_length);
	serv_addr.sin_port = htons(portnom);							/*CHANGE portnoN!!!*/
	if (connect(sockfd,(struct sockaddr *) &serv_addr,sizeof(serv_addr)) < 0) error("ERROR connecting");
	n = write(sockfd,str[0],64); if (n < 0) error("ERROR writing to socket");
	printf("Press any key and ENTER to close the file...\n"); getchar(); getchar();
	n = write(sockfd,str[1],64); if (n < 0) error("ERROR writing to socket");
	close(sockfd); //printf("\n---Flags=%s\t",str[0]); printf("name=%s---\n",str[1]);
  return 0;
 }
}
