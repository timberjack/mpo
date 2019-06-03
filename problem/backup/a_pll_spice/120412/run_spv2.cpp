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

double sp_ckt( double local_time, streampos* pp )
{

	ifstream myFile;
	string str_t2, str_vc2, substr_t2, substr_vc2, temp;
	double vc_1, t_1, vc_2, t_2;
	unsigned int i=0,j=0;

	//cout << "hi";
	
	//while(1)
	//{
		myFile.open("invco.tr0");
		//cout << local_time << '\n';
		
		if(myFile.is_open())
		{		
			myFile.seekg(*pp);
			while(!myFile.eof())	{
				if( i < 11 )	{
					getline(myFile,str_t2);
					cout << i << '\t' << str_t2 << '\n';
					t_1=0;	vc_1=0;	t_2=0;	vc_2=0;
					i++;
				}
				
				else if( i >= 11 )	{

					vc_1 = vc_2;	t_1 = t_2;	//cout << vc_2 << '\n';
					getline(myFile,str_t2);
					getline(myFile,str_vc2);
					getline(myFile,temp);
					
					//cout << i << '\t' << str_t2 << '\n';
					//cout << str_vc2 << '\n';
					//cout << temp << '\n';
					j=0;
					while(!isspace(str_t2[j])) j++;
					
					substr_t2 = str_t2.substr(j+2,str_t2.length());
					
					stringstream ss0(substr_t2);
					ss0 >> t_2;

					j=0;
					while(!isspace(str_vc2[j])) j++;
					//cout << str_vc2 << "\ncalling subtr\n";
					substr_vc2 = str_vc2.substr(1,str_vc2.length());
					
					stringstream ss3(substr_vc2);
					ss3 >> vc_2;
					//cout << "done calling subtr\n" << vc_2 << '\n';
					
					if( t_2 > local_time )	{
						*pp = myFile.tellg();
						myFile.close();
						return( (local_time-t_1)*(vc_2-vc_1)/(t_2-t_1)+vc_1 );		//linear interpolation
					}
					else if( t_2 == local_time )	{
						*pp = myFile.tellg();
						myFile.close();
						return( vc_2 );
					}
				}
			}
		}
	//myFile.close();
	//}
}

#endif
