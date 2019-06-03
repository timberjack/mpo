#ifndef _STATS_
#define _STATS_

#include <iostream>
#include <fstream>
#include <chrono>
#include <vector>
#include <iomanip>
#include "progressbar.hpp"
#include "utils.hpp"

using namespace std;
using namespace std::chrono;

class Stats
{
private:
	// time measure
	std::chrono::high_resolution_clock::time_point t_start;
	std::chrono::high_resolution_clock::time_point t_end;
	
	// result log
	ofstream log_result;

	// progress bar
	ProgressBar progress;
	
public:
	Stats(const string log_result_file)
	:progress(5000, 50, '-', ' ')
	{
		log_result.open(log_result_file.c_str());
		t_start = high_resolution_clock::now();
	};

	Stats()
	:progress(5000, 50, '-', ' ')
	{
		t_start = high_resolution_clock::now();
	};

	~Stats()
	{
		if(log_result.good())
		{
			log_result.close();
		}
	};

	void reset_clock();

	double get_elapsed_time();

	void write_log_headline();

	void write_log(double f_min, unsigned int nsample);

	/* display progress based upon number of evaluations */
	void print_display_n(double f_min, unsigned int nevals, double maxevals);

	void print_display(double f_min, double max_duration);

	void print_solution(std::vector<double> x_min, double f_min);
	
	void set_log(const string filename = "result.log")
	{
		log_result.open(filename.c_str());
		//write_log_headline();
	};

	const string set_auto_log()
	{
		string log_name = get_auto_name();
		log_result.open(log_name.c_str());
		return log_name;
		//write_log_headline();
	};

	void write_new_log(const string filename);

	static string get_auto_name();

	void reset()
	{
		
	};
};

#endif
