#include "dataset.hpp"

void Dataset::clear()
{
	mdata.clear();
	min_idx = 0;
	next_idx = 0;
};

/* insert a single sample into dataset */
unsigned long int Dataset::add_data(const VectorXd& newx, const double& newf)
{
	check_invalid({newx.size() != dim}, "add_data", "input dimension mismatches");
	mdata.emplace(next_idx, make_pair(newx, newf));
	unsigned long int idx = next_idx;
	update_min(idx);	
	next_idx++;
	return idx;
}

/* acquire a single sample based on given idx */
void Dataset::get_data(const unsigned long int& idx, VectorXd& newx, double& newf)
{
	check_invalid({idx > next_idx}, "get_data", "invalid indx");
	newx = mdata[idx].first;
	newf = mdata[idx].second;
};

/* for each inserted new sample, update min_idx */
void update_min(const unsigned long int& idx)
{
	if(mdata.empty())
	{
		min_idx = idx;
	}
	else
	{
		double fmin_mdata = mdata[min_idx].second;
		double f = mdata[idx].second;
		if(f < fmin_mdata)
		{
			min_idx = idx;
		}
	}
}

/* add_data alternative, allow for multiple data insertion */
vector<unsigned long int> Dataset::add_batch(const MatrixXd& newx, const VectorXd& newf)
{
	check_invalid({newx.cols() != newf.size()}, "add_data", 
	"xs and fs are different in number.");
	check_invalid({newx.cols() == 0}, "add_batch", "xs and fs should not be empty");

	// add batch of data
	vector<unsigned long int> batch_idx;	
	for(size_t i = 0; i < newx.cols(); i++)
	{
		unsigned long int idx = add_data(newx.col(i), newf(i));
		batch_idx.push_back(idx);
	}
	return batch_idx;
}

/* get_data alternative, allow for multiple data acquirement */
void Dataset::get_batch(const vector<unsigned long int>& idx, MatrixXd& newx, VectorXd& newf)
{
	check_invalid({idx.empty()}, "get_batch", "index list should not be empty");
	
	// get batch of data
	newx.resize(dim, idx.size());
	newf.resize(idx.size());
	for(size_t i = 0; i < idx.size(); i++)
	{
		VectorXd nx;
		double nf;
		get_data(idx[i], nx, nf);
		newx.col(i) = nx;
		newf(i) = nf;
	}
}

unsigned long int find_next_key()
{
	return next_idx;
};

