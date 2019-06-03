#ifndef	_RUN_SPV2_CPP
#define	_RUN_SPV2_CPP

#include<iostream>
#include<fstream>
#include<stdlib.h>
#include<pthread.h>
#include<string>
#include<sstream>
#include<ctype.h>

using namespace std;

double sp_ckt( double local_t, streampos* pp )
{

	ifstream myFile;
	string str_t2, str_vc2, substr_t2, substr_vc2;
	double vc_1, t_1, vc_2, t_2;
	unsigned int i=0,j=0;
	
	
	while(1)
	{
		myFile.open("invco.tr0");
		//cout << local_t << '\n';
		
		if(myFile.is_open())
		{		
			myFile.seekg(*pp);
			while(!myFile.eof())	{
				if( i < 10 )	{
					getline(myFile,str_t2);
					t_1=0;	vc_1=0;	t_2=0;	vc_2=0;
					i++;
				}
				
				else if( i >= 10 )	{

					vc_1 = vc_2;	t_1 = t_2;
					getline(myFile,str_t2);
					getline(myFile,str_vc2);
						
					//cout << vc_2 << '\n';
					j=0;
					while(!isspace(str_t2[j])) j++;
					substr_t2 = str_t2.substr(j+2,str_t2.length());
					stringstream ss0(substr_t2);
					ss0 >> t_2;

					j=0;
					while(!isspace(str_vc2[j])) j++;
					substr_vc2 = str_vc2.substr(1,str_vc2.length());
					stringstream ss3(substr_vc2);
					ss3 >> vc_2;
					
					if( t_2 > local_t )	{
						*pp = myFile.tellg();
						myFile.close();
						
						return( (local_t-t_1)*(vc_2-vc_1)/(t_2-t_1)+vc_1 );		//linear interpolation, NOT "out=(vc1+vc2)/2"
					}
					else if( t_2 == local_t )	{
						*pp = myFile.tellg();
						myFile.close();
						
						return( vc_2 );
					}
				}
			}
		}
	myFile.close();
	}
}

#endif
