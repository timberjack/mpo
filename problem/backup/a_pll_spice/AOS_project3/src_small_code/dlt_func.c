int   main(int   argc,   char   *argv[])
{
      if(remove(argv[1]))	printf("Fail to remove!\n");
	  else	printf("Remove file '%s'!\n", argv[1]);
      return   0;
}
