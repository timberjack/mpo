#include <iostream>
#include "config.hpp"

using namespace std;

int main()
{
	cout << "hello world" << endl;
	Config config;
	config.read();
	config.print();
	return 0;
}
