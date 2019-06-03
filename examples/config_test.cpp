#include <iostream>
#include <cstdlib>
#include <string>
#include "config.hpp"

using namespace std;

int main(int argc, char* argv[])
{
	cout << "config-test" << endl;
	string config_name;
	if(argc > 1)
	{
		config_name.assign(argv[1]);
	}
	else
	{
		config_name = "setting.ini";
	}
	Config config;
	config.read("setting.ini");
	config.print();
	return 0;
};
