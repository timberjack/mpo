#include "dataset.hpp"

void Dataset::reset_data(size_t dimi)
{
	mx.resize(dimi, 0);
	mf.resize(0);
	min_idx = 0;
	dim = dimi;
};

/* clear dataset */
void Dataset::clear_data()
{
	mx.resize(dim, 0);
	mf.resize(0);
	min_idx = 0;
};

/* add batch of samples into dataset and return indices to it */
vector<size_t> Dataset::add_data(const MatrixXd& x, const VectorXd& f)
{
	check_invalid({x.rows() != dim}, "dataset", 
		"new data dimension mismatches.");
	size_t n1 = mx.cols();
	mx.conservativeResize(NoChange, mx.cols() + x.cols());
	mx.rightCols(x.cols()) = x;
	mf.conservativeResize(mf.size() + f.size());
	mf.tail(f.size()) = f;
	size_t n2 = mx.cols();
	updatemin(f);
	vector<size_t> idx;
	for(size_t i = n1; i < n2; i++)
	{
		idx.push_back(i);
	}
	return idx;
};

void Dataset::add_gmin_f(double new_gmin_f)
{
	if(is_empty())
	{
		gmin_f = new_gmin_f;
	}
	else if(new_gmin_f < mf(min_idx))
	{
		gmin_f = new_gmin_f;
	}
};

size_t Dataset::add_data(const VectorXd& x, const double& f)
{
	check_invalid({x.size() != dim}, "dataset", 
		"new data dimension mismatches.");
	MatrixXd x_t(x.size(), 1);
	x_t.col(0) = x;
	VectorXd f_t(1);
	f_t(0) = f;
	vector<size_t> idx = add_data(x_t, f_t);
	return idx[0];
};

/* acquire a sample from a index */
void Dataset::get_data(const size_t& idx, VectorXd& x, double& f)
{
	check_invalid({idx >= mx.cols()},
			"dataset", "index exceeds dataset size.");
	x = mx.col(idx);
	f = mf(idx);
};

void Dataset::get_data(const vector<size_t>& idx, MatrixXd& x, VectorXd& f)
{
	x.resize(dim, idx.size());
	f.resize(idx.size());
	for(size_t i = 0; i < idx.size(); i++)
	{
		check_invalid({idx[i] >= size()}, "dataset", 
				"index exceeds dataset size.");
		x.col(i) = mx.col(idx[i]);
		f(i) = mf(idx[i]);
	}
};

MatrixXd Dataset::get_x()
{
	return mx;
};

VectorXd Dataset::get_f()
{
	return mf;
};

/* acquire minimum sample, including both input and output */
VectorXd Dataset::get_min_x()
{
	check_invalid({mx.cols() == 0, mx.cols() <= min_idx},
					"dataset", "cannot access min x.");
	return mx.col(min_idx);
};

double Dataset::get_min_f()
{
	check_invalid({mf.size() == 0, mf.size() <= min_idx},
					"dataset", "cannot access min x.");
	return mf(min_idx);
};

double Dataset::get_min_f(vector<size_t> idx)
{
	MatrixXd x;
	VectorXd f;
	get_data(idx, x, f);
	size_t idx_t;
	f.minCoeff(&idx_t);
	return f(idx_t);
};

double Dataset::get_gmin_f()
{
	return gmin_f;
};

size_t Dataset::updatemin(const VectorXd& f)
{
	if(f.size() != 0)
	{
		
		size_t new_min_idx;
		if(mx.cols() == 0)
		{
			f.minCoeff(&new_min_idx);
			min_idx = new_min_idx;
		}
		else if(f.minCoeff(&new_min_idx) < mf(min_idx))
		{
			min_idx = mf.size() - f.size() + new_min_idx;
		}

		if(mf(min_idx) < gmin_f)
		{
			gmin_f = mf(min_idx);
		}
	}
	return min_idx;
}

/* check if dataset is empty */
bool Dataset::is_empty()
{
	check_invalid({mx.cols() != mf.size()}, "dataset", 
		"inputs and outputs mismatch in number.");
	return (mx.cols() == 0);
};

/* check dataset size */
size_t Dataset::size()
{
	check_invalid({mx.cols() != mf.size()}, "dataset", "inputs and outputs mismatch in number.");
	return mx.cols();
};

void Dataset::print()
{
	check_invalid({mx.cols() != mf.size()}, " ", "dimension mismatches");
	ofstream log;
	log.open("dataset.log");
	log << "print dataset" << endl;
	for(size_t i = 0; i < mx.cols(); i++)
	{
		log << setw(20) << mx.col(i).transpose() << "|"
			<< setw(20) << setprecision(4) << mf(i) << endl;
 	}
	log.close();
}

MatrixXd Dataset::rescale(const MatrixXd& x, const MatrixXd& boundi)
{
	VectorXd _a = (boundi.col(1) - boundi.col(0))/2;
	VectorXd _b = 0.5 * (boundi.col(0) + boundi.col(1));
	return (_a.replicate(1, x.cols()).cwiseProduct(x).colwise() + _b);
};

void Dataset::solution(MatrixXd rbound)
{
	ofstream ofs("solution.out");
	cout << "Solution:" << endl;
	VectorXd x_real = rescale(get_min_x(), rbound);
	ofs << "xmin:" << endl;
	for(size_t i = 0; i < dim; i++)
	{
		cout << setw(8) << x_real(i) << endl;
		ofs << setw(8) << x_real(i) << endl;
	}
	cout << "Result: " << get_min_f() << endl;
	ofs << endl;
	ofs << "fmin: " <<get_min_f() << endl;
	cout << "NSample: " << size() << endl;
	ofs << "nsample: " << size() << endl;
};





