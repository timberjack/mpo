#include "node.hpp"

void Node::reset_data(size_t dim)
{
	odataset->reset_data(dim);
};

boost::shared_ptr<Dataset> Node::get_dataset()
{
	return odataset;
};

void Node::add_data(const MatrixXd& x, const VectorXd& f)
{
	odataset->add_data(x, f);
};

void Node::add_data(const VectorXd& x, const double& f)
{
	odataset->add_data(x, f);
};

void Node::add_gmin_f(double gmin_f)
{
	odataset->add_gmin_f(gmin_f);
};

MatrixXd Node::get_x()
{
	return odataset->get_x();
};

VectorXd Node::get_f()
{
	return odataset->get_f();
};

VectorXd Node::get_min_x()
{
	return odataset->get_min_x();
};
double Node::get_min_f()
{
	return odataset->get_min_f();
};
size_t Node::get_nsample()
{
	return odataset->size();
};

void Node::clear_data()
{
	odataset->clear_data();
};

MatrixXd Node::get_default_bound(size_t dim)
{
	MatrixXd m(dim, 2);
	m.col(0) = MatrixXd::Constant(dim, 1, -1);
	m.col(1) = MatrixXd::Constant(dim, 1, 1);
	return m;
};

void Node::print_progress()
{
	if((odataset->size()) && (odataset->size() <= oconfig.max_eval))
	{
		ostats.print_display_n(odataset->get_min_f(), odataset->size(), oconfig.max_eval);
	}
};

void Node::write_log()
{
	ostats.write_log(odataset->get_min_f(), odataset->size());
};
