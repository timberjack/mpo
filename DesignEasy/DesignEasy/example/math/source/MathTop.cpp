/**
    UT-Dallas
    RRC.cpp
    Purpose: Main program of mathematical testbench

    @author Zhaori Bi
    @version 1.0 11/19/2016
*/

#include <iostream>
#include <string>
#include <fstream>
#include <sstream>
#include <vector>
#include <map>
#include <stdlib.h>
#include <iterator>
#include <time.h>
#include "MathTestbench.hpp"

using namespace std;


main(int argc, char *argv[]){
	vector<double> x;					//	vector to store variables
	ifstream inFile(argv[1]);				//	open input file
	string line;
	double TempNum;
	while(getline(inFile, line)){
		istringstream record(line);
		record>>TempNum;				//	read number
		x.push_back(TempNum);
	}
	ofstream outFile(argv[2]);				//	open output file
	/********************** rosenbrick function ******************************/
	outFile<<"COST= "<<rosen(1,100,x[0],x[1])<<endl;	// write value
	/********************** ackley function ******************************/
	//outFile<<"COST= "<<ackley(20,0.2,2*3.1415926, x[0],x[1])<<endl;	// write value
	/********************** stright out function ******************************/
	//outFile<<"COST= "<<yEx(x[0])<<endl;
	/********************** Normal distributed random numbers, input=sigma ***/
	//outFile<<"COST= "<<NormalSigma(x[0])<<endl;
	outFile.close();
		
}
