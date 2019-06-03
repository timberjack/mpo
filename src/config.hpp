#ifndef _CONFIG_
#define _CONFIG_

#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <string>
#include <iostream>
#include "benchmark.hpp"
#include "ini.h"
#include <Eigen/Dense>
#include <map>

using namespace std;
using namespace Eigen;

/* configuration for optimization */
class Config
{
private:
	/* overall termination related */
	static int handler(void* user, const char* section, const char* name, const char* value);
	static int handler_problemlist(void* user, const char* section, 
				const char* name, const char * value);
public:
	/* problem related */
	string problem;
	string tool;
	string source;
	string mode;
	size_t dim;
	Func func;
	MatrixXd rbound;
	
	/* strategy related */
	string strategy;			// optimization strategy regarding overall domain
						// [options]: [dynamic_divide, static_divide
						//	    origin]
	string method;				// local search optimization choice
						// [options]: [bayesopt]
	
	/* domain options */
	int num_init_divide;		// number of initial divided sub-domains
						// (if defines to 0, set to number of 
						// available nodes)
	int num_random_sample;		// number of samples taken in initial stage 
						// (across overall domain)
	double min_region_size;			// minimum area of sub-domain
	int min_init_sample;		// minmum initial number of samples for GP training
	int msp_end_num;			
			// max number of failed local searches to terminate a local search
	int ls_end_num;				// max local searches without making improvement
	double min_lcb_diff;
	
	int sigma;  
	string hyptype;
	string div;

	/* region */
	int nstart_point;
	int region_max_nsample;

	/* termination */
	int max_eval;
	double max_duration;
	int max_update;
		
	/* multiple-thread */
	int nthread;

	/* information */
	int verbose_level;

	/* designeasy */
	string hspice;

	map<string, string> problemlist;
	
	Config()
		:problem("branin"),
		source(""),
		dim(1),
		strategy("dynamic_divide"),
		method("bayesopt"),
		mode("mpi"),
		num_init_divide(0),
		num_random_sample(10),
		min_region_size(0.01),
		min_init_sample(10),
		msp_end_num(21),
		ls_end_num(5),
		min_lcb_diff(0.1),
		sigma(3),
		hyptype("hyp"),
		div("lscale"),
		nstart_point(10),
		region_max_nsample(1000),
		max_eval(5000),
		max_duration(3600),
		max_update(50),
		verbose_level(0)
	{};
	void read(const string filename = "config.ini");
	void read_de(const string filename = "problemlist.ini");
	void print();
	void adjust();
	//void moveto(const string path);
};

#endif
