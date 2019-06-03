void CRT(char ch,filename[16]);
void RDO(char ch,filename[16]);
void WTO(char ch,filename[16]);
void ROS(char ch,filename[16], int lineno);
void WOS(char str[256],filename[16], int lineno);


#include <stdio.h>
#include <string.h>
/*---------------CREATE-A-FILE---------------*/
void CRT(char ch,filename[16]);
{FILE *fp;
char ch, filename[16];
printf("Pls create a file name (within 16 chars):\n");
scanf("%s", filename);
if((fp=fopen(filename,"r"))!=NULL)
  {printf("File exists!\n");
   getchar();
   exit(1);}
else if ((fp=fopen(filename,"w"))==NULL)
   {exit(0);}
ch=getchar();  //for last scanf '\n' //printf("\n");
printf("Creating new file\n");
printf("Pls enter file content (end with '^'):\n");
ch=getchar();
while (ch!='^')
     {fputc(ch,fp);
      //putchar(ch);
      ch=getchar();}
fclose(fp);}
/*---------------READ-A-FILE---------------*/
void RDO(char ch,filename[16]);
{FILE *fp;
char ch, filename[16];
printf("Pls enter a file name to read:\n");
scanf("%s", filename);
printf("\n");
if((fp=fopen(filename,"r"))==NULL)
  {printf("Error: Cannot find a non-exiting file!\n");
   getchar();
   exit(1);}
  //printf("\n");
  ch=fgetc(fp);
  while (ch!=EOF)
       {putchar(ch);
        ch=fgetc(fp);}
printf("\n");
fclose(fp);}
/*---------------WRITE-TO-EOF---------------*/
void WTO(char ch,filename[16]);
{FILE *fp;
char ch, filename[16];
printf("Pls enter a file name to write:\n");
scanf("%s", filename);
if((fp=fopen(filename,"r"))==NULL)
  {printf("Error: Cannot write to a non-exiting file!\n");
   getchar();
   exit(1);}
else if ((fp=fopen(filename,"a+"))!=NULL)
   {printf("Write to the end of file\n");
    //exit(0);
    ch=getchar(); 
    printf("Input some new content at EOF:\n");
    ch=getchar();
  while (ch!='^')
     {fputc(ch,fp);
      ch=getchar();}}
fclose(fp);}
/*---------------READ-A-LINE---------------*/
void ROS(char ch,filename[16], int lineno);
{FILE *fp;
char ch, filename[16],line[128];
int i=0, lineno;
printf("Pls enter a file name to read:\n");
scanf("%s",filename);
printf("\n");
getchar();
if((fp=fopen(filename,"r"))==NULL)
  {printf("Error: Cannot find a non-exiting file!\n");
   exit(1);}
else {printf("Pls enter a line # to read:\n");
      scanf("%d",&lineno);
      //ch=fgetc(fp);
while((fgets(line,sizeof line, fp)!=NULL) && (i < lineno))
     {i++;if(i == lineno) 
           {fputs(line, stdout);}}
      printf("\n");}
fclose(fp);}
/*---------------WRITE-AT-A-LINE---------------*/
void WOS(char str[256],filename[16], int lineno);
{FILE* fp=NULL;
int   Lid=0,MaxLine=0,lineno;  
char  filename[16],Buf[256]="",str[256]="",tmp[64][256]={0};  
printf("Pls enter a file name to write:\n");
scanf("%s", filename);
if((fp=fopen(filename,"r+"))==NULL)
  {printf("Error: Cannot write to a non-exiting file!\n");
   getchar();
   exit(1);}
else //if ((fp=fopen(filename,"a+"))!=NULL)
{printf("Pls enter a line # to write:\n");
      scanf("%d",&lineno);
      printf("Input a new string at that line:\n");
      scanf("%s",str);   
   while (fgets(Buf, 256 ,fp))  
   {Lid++; if(Lid == lineno)
             {strcpy(tmp[Lid++],str);}
              strcpy(tmp[Lid],Buf);} 
MaxLine=Lid;  
rewind(fp);  
for(Lid=1 ;Lid <= MaxLine;Lid++)
 {fputs(tmp[Lid],fp);}
 fclose(fp);} }
