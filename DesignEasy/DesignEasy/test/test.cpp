#include <stdlib.h>
#include <unistd.h>

int main()
{
  system("mkdir test1");
  system("pwd");
  chdir("test1");
  system("pwd");
  system("mkdir 1");
  return 0;
}
