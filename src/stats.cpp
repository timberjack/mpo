#include "stats.hpp"

void Stats::reset_clock()
{
	t_start = high_resolution_clock::now();
};

double Stats::get_elapsed_time()
{	
	t_end = high_resolution_clock::now();
	double t_duration = 
	(double)(duration_cast<milliseconds>(t_end - t_start).count())/1000;
	return t_duration;
};

void Stats::write_log_headline()
{
	if(log_result.good())
	{
		log_result << setw(20) << "elapsed_time/s" 
				<< setw(20) << "fmin" 
				<< setw(20) << "sample_size" << endl;   
	}
};

/*void Stats::write_log(double f_min, unsigned int nsample)
{
	if(log_result.good())
	{
		log_result << setw(20) << setprecision(4) << get_elapsed_time() 
			<< setw(20) << setprecision(4) << f_min
			<< setw(20) << nsample << endl;
	}
};*/

void Stats::write_log(double f_min, unsigned int nsample)
{
	if(log_result.good())
	{
		log_result << get_elapsed_time() 
			<< " " << f_min
			<< " " << nsample << endl;
	}
};

void Stats::write_new_log(const string filename)
{
	if(log_result.good())
	{
		log_result.close();
	}
	log_result.open(filename.c_str());
	t_start = high_resolution_clock::now();
};

/* display optimization based upon number of evaluations */
void Stats::print_display_n(double f_min, unsigned int nevals, double maxevals)
{
	check_invalid({maxevals == 0}, "stats",
				"invalid maxevals");
	progress.display_t(f_min, nevals, maxevals);
}

void Stats::print_display(double f_min, double max_duration)
{
	check_invalid({max_duration == 0}, "write_display", 
				"max duration undefined");
	progress.display_t(f_min, get_elapsed_time(), max_duration);
	
};

void Stats::print_solution(std::vector<double> x_min, double f_min)
{
	progress.done();
	cout << "Solution:\t" << endl;
	for(size_t i = 0; i < x_min.size(); i++)
	{
		cout << "\t"
			<< x_min[i] << endl;
	}
	cout << "Result:\t" << endl;
	cout << "\t" << f_min << endl;
};

string Stats::get_auto_name()
{
	int i = 0;
	bool is_found = true;
	ifstream ifs;
	string filename;
	while(is_found)
	{
		filename = "stats_" + to_string(i) + ".log";
		ifs.open(filename.c_str());
		if(ifs.good())
		{
			i++;
			ifs.close();
		}
		else
		{
			is_found = false;
		}
	}
	string cmd = "touch " + filename;
	int n = system(cmd.c_str());
	return filename;
};

