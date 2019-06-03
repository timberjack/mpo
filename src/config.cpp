#include "config.hpp"

/* handler to read in problem lsit */
int Config::handler_problemlist(void* user, const char* section, const char* name, const char* value)
{
	#define MATCH(s, n) strcmp(section, s) == 0 && strcmp(name, n) == 0
	Config* pconfig = (Config*)user;
	if(MATCH("designeasy", "hspice")) {
		pconfig->hspice.assign(value);
	}
	else if(strcmp(name, "source") == 0)
	{
		//string name(section);
		//string source(value);
		pconfig->problemlist[*(new string(section))] = *(new string(value));
		//problemlist[name] = value;
	}
}

/* internal, handler for options parsing */
int Config::handler(void* user, const char* section, const char* name, const char* value)
{
    Config* pconfig = (Config*)user;

    #define MATCH(s, n) strcmp(section, s) == 0 && strcmp(name, n) == 0
    if (MATCH("problem", "problem")) {
        pconfig->problem.assign(value);
    } else if (MATCH("problem", "tool")) {
		pconfig->tool.assign(value);
    } else if (MATCH("strategy", "strategy")) {
        pconfig->strategy.assign(value);
    } else if (MATCH("strategy", "method")) {
    	pconfig->method.assign(value);
	} else if (MATCH("strategy", "mode")) {
        pconfig->mode.assign(value);
    } else if (MATCH("option", "num_init_divide")) {
     	pconfig->num_init_divide = atoi(value);
    } else if (MATCH("option", "num_random_sample")) {
        pconfig->num_random_sample = atoi(value);
    } else if (MATCH("option", "min_region_size")) {
        pconfig->min_region_size = atof(value);
    } else if (MATCH("option", "min_init_sample")) {
		pconfig->min_init_sample = atoi(value);    
    } else if (MATCH("option", "msp_end_num")) {
		pconfig->msp_end_num = atoi(value);
	} else if (MATCH("option", "ls_end_num")) {
		pconfig->ls_end_num = atoi(value);
    } else if (MATCH("option", "sigma")) {
		pconfig->sigma = atoi(value);
	} else if (MATCH("option", "hyptype")) {
		pconfig->hyptype = value;
	} else if (MATCH("option", "div")) {
		pconfig->div = value;
    } else if (MATCH("option", "nthread")) {
		pconfig->nthread = atoi(value);
	} else if (MATCH("option", "nstart_point")) {
		pconfig->nstart_point = atoi(value);
	} else if (MATCH("option", "min_lcb_diff")) {
   		pconfig->min_lcb_diff = atof(value);
	} else if (MATCH("option", "region_max_nsample")) {
		pconfig->region_max_nsample = atoi(value);
	} else if (MATCH("termination", "max_duration")) {
		pconfig->max_duration = atof(value);     
    } else if (MATCH("termination", "max_eval")) {
		pconfig->max_eval = atoi(value);
	} else if (MATCH("termination", "max_update")) {
		pconfig->max_update = atoi(value);
    } else if (MATCH("info", "verbose_level")) {
		pconfig->verbose_level = atoi(value);
	} else {
        return 0;	/* unknown section/name, error */
    }
    return 1;
}

/* read in config file */
void Config::read(const string filename)
{
	if(ini_parse(filename.c_str(), handler, this) < 0)
	{
		cerr << "[error] cannot load " << filename << endl;
		exit(1);
	}
	if(tool == "designeasy")
	{
		read_de("de.ini");
		source = problemlist[problem];
	}
	func = get_func(problem, tool, source, dim, rbound);
	adjust();
}

/* read in problemlist file */
void Config::read_de(const string filename)
{
	if(ini_parse(filename.c_str(), handler_problemlist, this) < 0)
	{
		cerr << "[error] cannot load " << filename << endl;
		exit(1);
	}
}

void Config::adjust()
{
	if(min_init_sample < 2)
	{
		min_init_sample = 2;
		//log << "[adjust]\t"  << "adjust num_init_sample to " << min_init_sample
		//	<< "." << endl;
	}
	
	if(div == "lscale")
	{
		hyptype = "hyp_ls";
		//log << "[adjust]\t" << "adjust hyp parameter to hyp_ls." << endl; 
	}

	if(max_duration == 0)
	{
		max_duration = 2000;
		//log << "[adjust]\t" << "adjust max duration to " 
		//	<< max_duration << "." << endl;
	}

	// adjust based on method
	if(strategy == "dynamic_divide")
	{
		if(region_max_nsample == 0)
		{
			region_max_nsample = 500;
		}
		
		if(max_update == 0)
		{
			max_update = 20;
		}
	}

	if(strategy == "static_divide")
	{
		region_max_nsample = 0;
		if(max_update == 0)
		{
			max_update = 20;
		}
	}

	if(strategy == "nondivide")
	{
		region_max_nsample = 0;
		max_update = 0;
	}
}

/* print out configs */
void Config::print()
{
	cout << "[configs]" << endl;
	cout << "problem:       " << problem << endl;
	cout << "source:        " << source << endl;
	cout << "strategy:      " << strategy << endl;
	cout << "dim:	        " << dim << endl;
	cout << "rbound: 		" << rbound << endl;
	cout << "method: 		" << method << endl;
	cout << "num_init_divide: 	" << num_init_divide << endl;
	cout << "num_random_sample: " << num_random_sample << endl;
	cout << "min_region_size: 	" << min_region_size << endl;
	cout << "min_init_sample: 	" << min_init_sample << endl;
	cout << "msp_end_num: 	" << msp_end_num << endl;
	cout << "ls_end_num: 	" << ls_end_num << endl;
	cout << "sigma: 		" << sigma << endl;
	cout << "hyptype: 		" << hyptype << endl;
	cout << "div:			" << div << endl;
	cout << "nstart_point:	" << nstart_point << endl;
	cout << "region_max_nsample:	" << region_max_nsample << endl;
	cout << "max_eval: 		" << max_eval << endl;
	cout << "max_duration: 	" << max_duration << endl;
	cout << "max_update: 	" << max_update << endl;
	cout << "nthread:		" << nthread << endl;
	cout << "hspice:		" << hspice << endl;
	cout << "[configs end]" << endl;
}

/*void Config::moveto(const string path)
{
	string cmd = "mv " + config_file + " " + path;
	cout << "test moveto " << cmd << endl;
	int n = system(cmd.c_str());
}*/
