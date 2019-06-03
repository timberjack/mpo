#include <fstream>
#include <iostream>
#include <iterator>
#include <map>
#include <sstream>
#include <cstdlib>
#include <string>
#include <vector>
#include "deplugin.hpp"
#include "Initialization.hpp"
#include "FixWeightEvaluate.hpp"
#include "Auxi.hpp"

using namespace std;

void Interface1(int id)
{

  char file_name[40];
  sprintf(file_name, "runtime/%d/config", id);
  
	ifstream conFile(file_name);			//	readin configure file
	string Line;						//	string buffer
	string word;						//	string to record word
	vector<string> rawPara;				//	rawdata for the inputs of the interface settings
	bool ReadInFlag = 0;				//	Flag indicates to enter the reading state
	
/********************* Step 1. Read in the file name, etc. *****************/
	while (getline(conFile, Line)){
		istringstream tempLine(Line);	// read file line by line
		if (ReadInFlag == 1)			// reading section
			rawPara.push_back(Line);
	
		tempLine >> word;
		if (word == "#"){				//	check the Flow setting sections
			if (ReadInFlag == 1) break;	//	end reading
			tempLine >> word;
			if(word == "Flow")			//	enter the reading section
				ReadInFlag = 1;
		}	
	}
	if(ReadInFlag == 0) {				//	report error if cannot find keyword
		cerr<<"Cannot find # Flow # line"<<endl;
		exit(1);
	}
	vector<string>::iterator it=rawPara.begin();	//	transfer data 

	int i=0;							// 	index to search each raw data line
	int Pos=0;							//	current position(line) of definitions
	bool writeFlag=false;						//	flag to write
	string NetListName;					// 	record the NetListName
	string DataOutName;					//	record the output file name
	for(it=rawPara.begin(); it != rawPara.end()-1; ++it){	//	record the parameters
		string tempString=*it;
		++Pos;						//	record the current position
		writeFlag=false;
		for(i=0; i!=it->size();++i){
			if(Pos==1 && writeFlag)				//	Netlist name
				NetListName+=tempString[i];
			if(Pos==2 && writeFlag)				//	Output file name
				DataOutName+=tempString[i];	
			if(tempString[i]==':') writeFlag=true;					
		}
	}

/************ Step 2. Read in variable's value and generate output ***************/

	sprintf(file_name, "runtime/%d/Trival.in", id);
			
	ifstream inFile(file_name);		//	trival input file Trival.in

	sprintf(file_name, "runtime/%d/Trival.out", id);
	ofstream outFile(file_name);		//	cost return to file Trival.out
	vector<double> InVal;			//	number vector to record value
	double TempNum;				//	number buffer
	
	while(getline(inFile,Line)){		//	read in the trival value from input file
		istringstream record(Line);
		record>>word;
		TempNum=StringToNumber(word);
		if (TempNum>10){				//	check if the inputs in the range [-10,10]
			cerr<<"The input variable vaule ("<<TempNum<<") greater than UPPER LIMIT 10"<<endl;
			exit(1);			
		}
		if (TempNum<-10){				//	check if the inputs in the range [-10,10]
			cerr<<"The input variable vaule ("<<TempNum<<") smaller than LOWER LIMIT -10"<<endl;
			exit(1);			
		}		
		InVal.push_back(TempNum);
	}

	NetListName = "de/" + NetListName;
	outFile<<FixWeightEvaluate(NetListName,DataOutName,InVal, id);
	outFile.close();
}
