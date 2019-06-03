#include "benchmark.hpp"

Func get_func(const string problem, const string tool, const string source, size_t& dim, MatrixXd& bound)
{
	Func f;
	if(tool == "designeasy")
	{
		f = designeasy_port;
		parseDesignEasy(source, dim, bound);
	}
	else if(tool == "math")
	{
		if(problem == "branin")
		{
			f = branin;
			dim = 2;
			bound.resize(dim, 2);
			bound.col(0) << -5, 0;
			bound.col(1) << 10, 15;
		}
		else
		{
			cerr << "[error] get_func: math function " << problem << " not available" 
			<< ", consider to add it into benchmark.cpp." << endl;
			exit(1);
		}
	}
	else
	{
		cerr << "[error] get_func: evaluation tool " << tool << " not supported." << endl;
		exit(1); 
	}
	return f;
}

void parseDesignEasy(const string source, size_t& dim, MatrixXd& bound)
{
	char curr_path[100];
	char * curr_path_ptr;
	curr_path_ptr = getcwd(curr_path, 100);
	int n = chdir(source.c_str());
	if(n < 0)
	{
		cerr << "[error] invalid source path [" << source << "]." << endl;
		exit(1); 
	}
 	map<string, Para*> Parameters;
	Parameters = ReadParaConfig();
	//Parameters = ReadPara(0);
	dim = 0;
	bound.resize(dim, 2);
	for(map<string, Para*>::iterator it = Parameters.begin(); it != Parameters.end(); it++)
	{
		if(it->second->ob())
		{
			dim++;
		}
	}
	n = chdir(curr_path);

	/* get parameter lower & upper bounds */
	/*bound.resize(dim, 2);
	size_t count = 0;
	for(map<string, Para*>::iterator it = Parameters.begin(); it != Parameters.end(); it++)
	{
		if(it->second->ob())
		{
			bound.col(0)(count) = it->second->lb();
			bound.col(1)(count) = it->second->ub();
			count++;
		}
	}*/
	bound.resize(dim, 2);
	bound.col(0) = MatrixXd::Constant(dim, 1, -1);
	bound.col(1) = MatrixXd::Constant(dim, 1, 1);
	//check_invalid({count != dim}, "parseDesignEasy", "dimension mismatches.")d;
}

double designeasy_port(const VectorXd& x, int i)
{
	/* enter problem folder */
	//string wpath = "de";
	//int n = chdir(wpath.c_str());

	size_t dim = x.rows();
	double f;
	//int n = system("mkdir runtime");
	char cmd[100];
	sprintf(cmd, "mkdir runtime/%d", i);
	int n = system(cmd);
	sprintf(cmd, "cp de/sim.tcl runtime/%d", i);
	n = system(cmd);
	sprintf(cmd, "cp de/config runtime/%d", i);
	n = system(cmd);
	char file_name[100];
	sprintf(file_name, "runtime/%d/Trival.in", i);
	ofstream out_file(file_name);
	
	/* designeasy requires optimization in opt domain [-1  1] */
	for(size_t d = 0; d < dim; d++)
	{
		out_file << (x(d) * 10) << endl;
	}
	out_file.close();
	Interface1(i);
	sprintf(cmd, "rm -f runtime/%d", i);
	sprintf(cmd, "rm -f runtime/%d/SpecMeas.log", i);
	n = system(cmd);
	sprintf(file_name, "runtime/%d/Trival.out", i);
	ifstream in_file(file_name);
	string line;
	getline(in_file, line);
	istringstream record(line);
	record >> f;
	sprintf(cmd, "rm -r runtime/%d", i);
	n = system(cmd);
	/* go to parent directory of problem folder */
	//wpath = "..";
	//n = chdir(wpath.c_str());
	return f;
}

/*VectorXd designeasy_port(const MatrixXd& x, int nthread)
{
	size_t dim = x.rows();
	size_t num = x.cols();
	VectorXd v_result(num);
	int num_threads
	if(nthread == 0)
	{
		num_threads = omp_get_num_threads();
	}
	else
	{
		num_threads = nthread;
	}

	int n = system("mkdir runtime");
	char cmd[100];
	if(size_t i = 0; i < num_threads; i++)
	{
		sprintf(cmd, "mkdir runtime/%d", i);
		n = system(cmd);
		sprintf(cmd, "cp sim.tcl runtime/%d", i);
		n = system(cmd);
		sprintf(cmd, "cp config runtime/%d", i);
		n = system(cmd);
	}
	
#pragma omp parallel for
	for(size_t n = 0; n < (size_t)x.cols(); n++)
	{
		char file_name[100];
		int thread_id = omp_get_thread_num();
		sprintf(file_name, "runtime/%d/Trival.in", thread_id);
		ofstream out_file(file_name);
		
		// designeasy requires optimization in opt domain [-1  1]
		for(size_t d = 0; d < dim; d++)
		{
			out_file << (x(d, n) * 10) << endl;
		}
		out_file.close();
		Interface(thread_id);
		char cmd[100];
		sprintf(cmd, "rm -f runtime/%d/SpecMeas.log", thread_id);
		n = system(cmd);
		sprintf(file_name, "runtime/%d/Trival.out", thread_id);
		ifstream in_file(file_name);
		string line;
		getline(in_file, line);
		istringstream record(line);
		record >> result;
		return result;
	}
}*/

double sqr(double x)
{
	return (x * x);
}

double branin(const VectorXd& x, int i)
{
	if(x.rows() != 2)
	{
		cerr << "[error] branin is dimension 2, mismatched with input " << x.rows () << endl; 
	}
	size_t num = x.cols();
	double f;
	const double pi = boost::math::constants::pi<double>();
     	const double rpi = pi*pi;
	f = sqr(x(1)-(5.1/(4*rpi))*sqr(x(0))
	       +5*x(0)/pi-6)+10*(1-1/(8*pi))*cos(x(0))+10;
	return f;
}

/*VectorXd math_grlee12(const MatrixXd& x)
{
	if(x.rows() != 1)
	{
		cerr << "[error] grlee12 is dimension 1, mismatched with input " << x.rows () << endl; 
	}
	VectorXd y(x.cols());
	const double pi = boost::math::constants::pi<double>();
	
	MatrixXd bound;
	bound.resize(1, 2);
	VectorXd lb(1), ub(1);
	lb << 0.5;
	ub << 2.5;
	bound.col(0) = lb;
	bound.col(1) = ub;

	for(size_t i = 0; i < x.cols(); i++)
	{
		VectorXd mx(1);
		mx = rescale(x.col(i), bound);
		double term1 = sin(10 * pi * mx(0))/(2 * mx(0));
		double term2 = pow(mx(0) - 1, 4);
		y(i) = term1 + term2;
	}
	return y;
}

VectorXd math_langermann(const MatrixXd& x)
{
	if(x.rows() != 2)
	{
		cerr << "[error] langermann is dimension 2, mismatched with input " << x.rows () << endl; 
	}
	MatrixXd y(1, x.cols());
	const double pi = boost::math::constants::pi<double>();
	
	MatrixXd bound;
	bound.resize(2, 2);
	VectorXd lb(2), ub(2);
	lb << 0, 0;
	ub << 10, 10;
	bound.col(0) = lb;
	bound.col(1) = ub;

	unsigned int m = 5;
	VectorXd c(5);
	c << 	1,2,5,2,3;
	MatrixXd A(5, 2);
	A << 	3,5,
		5,2,
		2,1,
		1,4,
		7,9;
	for(size_t d = 0; d < x.cols(); d++)
	{
		VectorXd mx(2);
		mx = rescale(x.col(d), bound);
		double f = 0.0;
		for(size_t i = 0; i < m; i++)
		{
			double term1 = 0.0;
			double term2 = 0.0;
			double temp = 0.0;
			for(size_t j = 0; j < 2; j++)
			{
				double term = pow((mx(j) - A(i, j)), 2);
				temp += term;
			}
			term1 = exp(-temp/pi);
			term2 = cos(temp * pi);
			f += c(i) * term1 * term2;
		}
		y(0, d) = f;
	}
	return y;
}

VectorXd math_eggholder(const MatrixXd& x)
{
	if(x.rows() != 2)
	{
		cerr << "[error] eggholder is dimension 2, mismatched with input " << x.rows () << endl; 
	}
	VectorXd y(x.cols());
	const double pi = boost::math::constants::pi<double>();
	
	MatrixXd bound;
	bound.resize(2, 2);
	VectorXd lb(2), ub(2);
	lb << -512, -512;
	ub << 512, 512;
	bound.col(0) = lb;
	bound.col(1) = ub;

	for(size_t d = 0; d < x.cols(); d++)
	{
		VectorXd mx(2);
		mx = rescale(x.col(d), bound);
		std::cout << "mx: 	" << mx << std::endl;
		double term1 = mx(1) + 47;
		double term2 = sin(sqrt(abs(mx(0)*1.0/2 + term1)));
		double term3 = mx(0);
		double term4 = sin(sqrt(abs(mx(0) - term1)));
		double f = -term1 * term2 - term3 * term4;
		y(d) = f;
	}
	return y;
}*/

// unscale bound [lb, ub] into [-1, 1]
MatrixXd unscale(const MatrixXd& x, const MatrixXd& bound)
{
	if((bound.cols() != 2) || (bound.cols() != 2))
	{	
		cerr << "[error] lower & upper bound should be set to 2 columns" << endl;
		exit(1);
	}
	VectorXd _a, _b;
	_a = (bound.col(1) - bound.col(0))/2;
	_b = (bound.col(1) + bound.col(0))/2;
	return (x.colwise() - _b).cwiseQuotient(_a.replicate(1, x.cols()));
}

// rescale bound [-1, 1] backto [lb, ub]
MatrixXd rescale(const MatrixXd& x, const MatrixXd& bound)
{
	if((bound.cols() != 2) || (bound.cols() != 2))
	{	
		cerr << "[error] lower & upper bound should be set to 2 columns" << endl;
		exit(1);
	}
	VectorXd _a, _b;
	_a = (bound.col(1) - bound.col(0))/2;
	_b = (bound.col(1) + bound.col(0))/2;
	return (_a.replicate(1, x.cols()).cwiseProduct(x).colwise() + _b);
}

void setDE(const string source, const string hspice, const string sp)
{
	if(isexist("de"))
	{
		removedir("de");
	}
	makedir("de");
	copyallto(source, "de");
	if(isexist("runtime"))
	{
		removedir("runtime");
	}
	makedir("runtime");
	moveto("de/sim.tcl", "de/sim0.tcl");
	ifstream infile_sim("de/sim0.tcl");
	ofstream outfile_sim("de/sim.tcl");
	string oldtool = "hspice64";
	string line;
	while(!infile_sim.eof())
	{
		getline(infile_sim, line);
		if(line.find(oldtool) != string::npos)
		{
			size_t idx = line.find(oldtool);
			line.erase(idx, oldtool.size()); 
			line.insert(idx, hspice);
		}
		outfile_sim << line << "\n";
	}
	infile_sim.close();
	outfile_sim.close();

	string sp_file = "de/" + sp + ".sp";
	moveto(sp_file, "de/origin.sp");
	ifstream infile_sp("de/origin.sp");
	ofstream outfile_sp(sp_file.c_str());
	int nline = 0;
	while(!infile_sp.eof())
	{
		getline(infile_sp, line);
		if(nline == 1)
		{
			outfile_sp << ".OPTION SEARCH=\'de\'\n";
		}
		outfile_sp << line << "\n";
		nline++;
	}
	infile_sp.close();
	outfile_sp.close();
};

