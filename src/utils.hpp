#ifndef _UTILS_
#define _UTILS_

#include <iostream>
#include <vector>
#include <algorithm>
#include <cstdlib>
#include <string>
#include <sys/stat.h>
#include <unistd.h>
//#include <Eigen/Dense>

using namespace std;
//using namespace Eigen;

#ifdef MYDEBUG
#define MYASSERT(x)                                           \
    if (!(x))                                                 \
    {                                                         \
        std::cerr << "Assertion failed: " << #x << std::endl; \
        std::cerr << "\tFile: " << __FILE__ << endl;          \
        std::cerr << "\tLine: " << __LINE__ << endl;          \
        std::cerr << "\tFunc: " << __func__ << endl;          \
        exit(EXIT_FAILURE);                                   \
    }
#else
#define MYASSERT(x) assert(x)
#endif

// rescale, support for user-defined domain
// map from opt domain to user-define domain
/*MatrixXd unscale(const MatrixXd& x, const MatrixXd& boundi); 
	
// map from user-define domain to opt domain
MatrixXd rescale(const MatrixXd& x, const MatrixXd& boundi);*/

void check_invalid(vector<bool> conditions, const string& tag, 
			const string& error_message);

void copyallto(const string filename, const string path);

void copyto(const string filename, const string path);

void moveto(const string filename, const string path);

void makedir(const string folder);

void removedir(const string folder);

void removefile(const string filename);

void rename(const string prev, const string curr);

bool isexist(const string path);

void gotopath(const string path);

#endif
