#include "optbase.hpp"

/*MatrixXd OptBase::rescale(const MatrixXd& x)
{
	VectorXd _a = (bound.col(1) - bound.col(0))/(scaled_ub - scaled_lb);
	VectorXd _b = 0.5 * (bound.col(0) + bound.col(1));
	return (_a.replicate(1, x.cols()).cwiseProduct(x).colwise() + _b);
};

MatrixXd OptBase::unscale(const MatrixXd& x)
{	
	VectorXd _a = (bound.col(1) - bound.col(0))/(scaled_ub - scaled_lb);
	VectorXd _b = 0.5 * (bound.col(0) + bound.col(1));
	return (x.colwise() - _b).cwiseQuotient(_a.replicate(1, x.cols()));
};*/

MatrixXd OptBase::get_rand_matrix(size_t num)
{
	return rand_matrix(num, VectorXd::Constant(dim, 1, scaled_lb), 
			VectorXd::Constant(dim, 1, scaled_ub), engine);
};

MatrixXd OptBase::rand_matrix(size_t num, const Eigen::VectorXd& lb, const Eigen::VectorXd& ub,
				mt19937_64& eig)
{
	check_invalid({ub.size() != dim, lb.size() != dim},
			"rand_matrix", "lower or upper bound does not match dimension.");
	check_invalid({(lb.array() > ub.array()).all()},
			"rand_matrix", "some value in lower bound is larger than upper bound.");
	MatrixXd m(dim, num);
	uniform_real_distribution<double> distr(-1, 1);
	const VectorXd _a = 0.5 * (ub - lb);
	const VectorXd _b = 0.5 * (ub + lb);
	for(size_t i = 0; i < num; i++)
		for(size_t d = 0; d < dim; d++)
		{
			m(d, i) = distr(eig);
		}
	m = _a.replicate(1, num).cwiseProduct(m).colwise() + _b;
	return m;
};

bool OptBase::better(const double f1, const double f2)
{
	if(f1 < f2)
	{
		return true;
	}
	else
	{
		return false;
	}
};

matrixd OptBase::eig_to_ublas_m(const MatrixXd m)
{
	matrixd rm(m.cols(), m.rows());
	for(size_t i = 0; i < m.rows(); i++)
		for(size_t j = 0; j < m.cols(); j++)
		{
			rm(j, i) = m(i, j);
		}
	return rm;
};

vectord OptBase::eig_to_ublas_v(const VectorXd v)
{
	vectord rv(v.size());
	for(size_t i = 0; i < v.size(); i++)
	{
		rv(i) = v(i);
	}
	return rv;
};

MatrixXd OptBase::vec_eig_to_eig_m(const vector<VectorXd> v)
{
	check_invalid({v.empty()}, "vec_eig_to_eig_m", "empty vector.");
	MatrixXd m(v[0].size(), v.size());
	for(size_t i = 0; i < v.size(); i++)
	{
		m.col(i) = v[i];
	}
	return m;
}

MatrixXd OptBase::ublas_to_eig_m_v(vector<vectord> v)
{
	check_invalid({v.empty()}, "ublas_to_eig_m_v", "empty vector eigen");
	MatrixXd m(v[0].size(), v.size());
	for(size_t i = 0; i < v.size(); i++)
	{
		m.col(i) = ublas_to_eig_v(v[i]);
	}
	return m;
}

MatrixXd OptBase::ublas_to_eig_m(matrixd m)
{
	MatrixXd rm(m.size2(), m.size1());
	for(size_t i = 0; i < m.size1(); i++)
		for(size_t j = 0; j < m.size2(); j++)
		{
			rm(j, i) = m(i, j);
		}
	return rm;
};

VectorXd OptBase::ublas_to_eig_v(vectord v)
{
	VectorXd rv(v.size());
	for(size_t i = 0; i < v.size(); i++)
	{
		rv(i) = v(i);
	}
	return rv;
};

vector<double> OptBase::eig_to_vec_v(VectorXd v)
{
	vector<double> rv(v.data(), v.data() + v.size());
	return rv;
};

VectorXd OptBase::vec_to_eig_v(vector<double> v)
{
	VectorXd rv = Map<VectorXd>(v.data(), v.size());
	return rv;
};

MatrixXd OptBase::sdist_mm(const MatrixXd X, const MatrixXd Y)
{
    MatrixXd dists(X.cols(), Y.cols());
    for(size_t i = 0; i < (size_t)Y.cols(); ++i)
        dists.col(i) = sdist_vm(Y.col(i), X);
    return dists;
};

double OptBase::sdist_vv(const VectorXd v1, const VectorXd v2) 
{	
	return (v1 - v2).squaredNorm();
};

VectorXd OptBase::sdist_vm(const VectorXd v, const MatrixXd m)
{
	return (m.colwise() - v).colwise().squaredNorm();
};

MatrixXd OptBase::rescale(const MatrixXd& x, const MatrixXd& boundi)
{
	VectorXd _a = (boundi.col(1) - boundi.col(0))/(scaled_ub - scaled_lb);
	VectorXd _b = 0.5 * (boundi.col(0) + boundi.col(1));
	return (_a.replicate(1, x.cols()).cwiseProduct(x).colwise() + _b);
};

MatrixXd OptBase::unscale(const MatrixXd& x, const MatrixXd& boundi)
{	
	VectorXd _a = (boundi.col(1) - boundi.col(0))/(scaled_ub - scaled_lb);
	VectorXd _b = 0.5 * (boundi.col(0) + boundi.col(1));
	return (x.colwise() - _b).cwiseQuotient(_a.replicate(1, x.cols()));
};

void OptBase::rand_sample(unsigned int num, MatrixXd& optx, VectorXd& optf)
{
	optx = get_rand_matrix(num);
	optf = run_func(optx);
	optx = rescale(optx, bound);
};

void OptBase::add_sample(const MatrixXd& x, const VectorXd& f)
{
	vector<size_t> idx = odataset->add_data(x, f);
	last.insert(last.end(), idx.begin(), idx.end());
}

void OptBase::add_sample_old(const MatrixXd& x, const VectorXd& f)
{
	vector<size_t> idx = odataset->add_data(x, f);
}

MatrixXd OptBase::get_x()
{
	return odataset->get_x();
}

VectorXd OptBase::get_f()
{
	return odataset->get_f();
}

void OptBase::move_new_sample(MatrixXd& x, VectorXd& f)
{
	odataset->get_data(last, x, f);
	last.clear();
}

size_t OptBase::get_n_new_sample()
{
	return last.size();
};

VectorXd OptBase::get_best_x()
{
	return odataset->get_min_x();
};

double OptBase::get_best_f()
{
	return odataset->get_min_f();
};

double OptBase::get_ref_best_f()
{
	return ref_best_f;
};

size_t OptBase::get_size()
{
	return odataset->size();
};

void OptBase::set_ref_best_f(double value)
{
	ref_best_f = value;
};

MatrixXd OptBase::outofbound_check(MatrixXd x)
{
	return (x.cwiseMax(scaled_lb).cwiseMin(scaled_ub));
};

void OptBase::solution()
{
	odataset->solution(rbound);
	ofstream ofs("solution.out");
	ofs << "Solution:" << endl;
	VectorXd x_real = rescale(get_best_x(), rbound);
	for(size_t i = 0; i < dim; i++)
	{
		ofs << setw(8) << x_real(i) << endl;
	}
	ofs << "Result: " << get_best_f() << endl;
	ofs << "NSample: " << odataset->size() << endl;
	ofs.close();
};

