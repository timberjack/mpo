#include "utils.hpp"

/*MatrixXd rescale(const MatrixXd& x, const MatrixXd& boundi)
{
	VectorXd _a = (boundi.col(1) - boundi.col(0))/(scaled_ub - scaled_lb);
	VectorXd _b = 0.5 * (boundi.col(0) + boundi.col(1));
	return (_a.replicate(1, x.cols()).cwiseProduct(x).colwise() + _b);
};

MatrixXd unscale(const MatrixXd& x, const MatrixXd& boundi)
{	
	VectorXd _a = (boundi.col(1) - boundi.col(0))/(scaled_ub - scaled_lb);
	VectorXd _b = 0.5 * (boundi.col(0) + boundi.col(1));
	return (x.colwise() - _b).cwiseQuotient(_a.replicate(1, x.cols()));
};*/

void check_invalid(vector<bool> conditions, const string& tag, const string& error_message)
{
	if(find(conditions.begin(), conditions.end(), true) != conditions.end())
	{
		cout << "[error] " << tag << ": " << error_message << endl;
		exit(1);
	}
};

void copyto(const string filename, const string path)
{
	string cmd = "cp -r " + filename + " " + path;
	int n = system(cmd.c_str());
};

void copyallto(const string filename, const string path)
{
	string filename_m = filename;
	if(filename_m.back() != '/')
	{
		filename_m.append("/");
	}
	string cmd = "cp -r " + filename_m + "* " + path;
	int n = system(cmd.c_str());
};

void moveto(const string filename, const string path)
{
	copyto(filename, path);
	string cmd = "rm -r " + filename;
	int n = system(cmd.c_str());
};

void makedir(const string folder)
{
	string cmd = "mkdir " + folder;
	int n = system(cmd.c_str());
};

void removedir(const string folder)
{
	string cmd = "rm -r " + folder;
	int n = system(cmd.c_str()); 
};

void removefile(const string filename)
{
	string cmd = "rm " + filename;
	int n = system(cmd.c_str());
};

void rename(const string prev, const string curr)
{
	string cmd = "mv " + prev + " " + curr;
	int n = system(cmd.c_str());
};

bool isexist(const string path)
{
	struct stat buf;
	return(stat(path.c_str(), &buf) == 0);
};

void gotopath(const string path)
{
	int n = chdir(path.c_str());
};

