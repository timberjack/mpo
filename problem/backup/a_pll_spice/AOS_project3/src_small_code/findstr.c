#include <stdio.h>
#include <string.h>

int main(void)
{
 char str[128], s2[128];
 FILE *fp;
 int j, flag=1;
	 
	  printf("Pls enter the smaller string.\n");
 scanf("%s",s2);
 //strcat(s2,&ent);
	 fp = fopen("test","r");
 // printf("Smaller string is %s.\n", s2);

 while (flag==1) {
	 bzero(str,128);
      for(j = 0; j < 128; j++){
            fscanf(fp,"%c",&str[j]);
             if (str[j] == '\n') {
			   str[j]='\0'; 
			   printf("SSSSSString is %s.\n", str);
			   break;}
			 else if (str[j] == '\0') {
			   flag = 0; break;}
	    }
			   
	 if (strcmp(str,s2)==0) flag = 2;
	 else printf("THE SSString is %s.\n", str);
  } 
	 if (flag==0) printf("Where is %s???\n",s2);
	 else if (flag==2) printf("Find it!\n");
}
