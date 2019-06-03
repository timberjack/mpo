#include <dirent.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

int main() {
struct dirent* ent = NULL;			// this struct has "d_reclen", "d_type", and "d_name"
DIR *pDir;
int i, flag;
char buf[1024], meta[1024], enter[] = {'\n','\0'};
FILE *fp;

bzero (meta,1024);
getcwd(buf,1024);
pDir=opendir(buf);

//for (i=-2;i<16;i++){
while (NULL != (ent=readdir(pDir))) {
 if (ent->d_reclen!=16)	{	// d_reclen: 16-child_directory (or starting with '.'), 24-binary_file, 28-non_child_directory
  if (ent->d_type==8) {        // d_type: 4-directory, 8-file
   strcat(meta,ent->d_name); 
   strcat(meta,enter);
    //strcpy(meta[i],ent->d_name);}		//printf("%s\n", ent->d_name);	
	//meta[i]=d_name;}			//printf("%d=%s\n",i,meta[i]);}
 }
}
}
//else break;}

printf("\nFiles are:\n");
for (i=0;i<1024;i++) {
if (meta[i] != '\0')
 printf("%c",meta[i]);
else {printf("\n"); break;}
}

fp=fopen("test","w");
                  	  for( i = 0; i < 1024; i++){               
                       	if(meta[i] != '\0') fputc(meta[i],fp);
                        else break;}
fclose(fp);
}
