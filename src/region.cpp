#include "region.hpp"

/* get region bound */
const MatrixXd Region::get_bound()
{
	return bound;
}

/* add data to a region, also add data into its parent region */
void Region::add_data(const MatrixXd& newx, const VectorXd& newf)
{
	vector<size_t> idx = dataset->add_data(newx, newf);
	data_idx.insert(data_idx.end(), idx.begin(), idx.end());
	if(pregion)
	{
		pregion->add_data_idx(idx);
	}
}

/* get data from this region according to indices */
void Region::get_data(vector<size_t> idx, MatrixXd& newx, VectorXd& newf)
{
	dataset->get_data(idx, newx, newf);
}

/* get data from this region according to a single index*/
void Region::get_data(size_t idx, VectorXd& newx, double& newf)
{
	dataset->get_data(idx, newx, newf);
}

/* get all data from this region */
void Region::get_data(MatrixXd& newx, VectorXd& newf)
{
	dataset->get_data(data_idx, newx, newf);
}

double Region::get_min_f()
{
	return (dataset->get_min_f(data_idx));
}

void Region::get_division(const MatrixXd& bound, MatrixXd& bound_d, 
		size_t n, const VectorXd hyp_ls, const string div_option)
{
	bound_d.resize(dim, 2 * n);
	MatrixXd lb(dim, n);
	MatrixXd ub(dim, n);
	VectorXd hyp_list = hyp_ls;
	divide_step(bound, lb, ub, 0, n-1, hyp_list, div_option);
	for(size_t i = 0; i < n; i++)
	{
		bound_d.col(2 * i) = lb.col(i);
		bound_d.col(2 * i + 1) = ub.col(i);
	}
}

void Region::divide_step(const MatrixXd bound, MatrixXd& lb, MatrixXd& ub,
		size_t start, size_t end, VectorXd& hyp_list, const string option)
{
	check_invalid({start > end}, 
		"divide", "start should not be larger than end.");
	MatrixXd bound_1;
	MatrixXd bound_2;
	if(start == end)
	{
		lb.col(start) = bound.col(0);
		ub.col(start) = bound.col(1);
	}
	else if(start < end)
	{
		bound_1 = bound;
		bound_2 = bound;
		size_t idx;
		if(option == "max_lscale")
		{
			idx = divide_dim_2(hyp_list);
		}
		else if(option == "min_lscale")
		{
			idx = divide_dim_3(hyp_list);
		}
		else if(option == "max_blength")
		{
			idx = divide_dim_1(bound);
		}
		int n = end - start + 1;
		double stepsize = (bound(idx, 1) - bound(idx, 0))/n;
		int stepnum = (int)(ceil(n * 1.0 /2));
		bound_1(idx, 1) = bound(idx, 0) + stepnum * stepsize;
		bound_2(idx, 0) = bound_1(idx, 1);
		divide_step(bound_1, lb, ub, start, start + stepnum - 1, hyp_list, option);
		divide_step(bound_2, lb, ub, start + stepnum, end, hyp_list, option);
	}	
}

size_t Region::divide_dim_1(const MatrixXd bound_div)
{
	size_t idx;
	(bound_div.col(1) - bound_div.col(0)).maxCoeff(&idx);
	return idx;
}

size_t Region::divide_dim_2(VectorXd& hyp_list)
{
	size_t idx;
	hyp_list.maxCoeff(&idx);
	hyp_list[idx] = hyp_list[idx]/2;
	return idx;
}

size_t Region::divide_dim_3(VectorXd& hyp_list)
{
	size_t idx;
	hyp_list.minCoeff(&idx);
	hyp_list[idx] = hyp_list[idx] * 2;
	return idx;
}

/* divide a region into defined number of sub-regions */
bool Region::divide(int nc, const string div_option)
{
	check_invalid({!cregions.empty()}, "divide", 
		"cannot divide when a region has sub-regions.");
	if(nc <= 1)
	{
		return false;
	}
	//vector<MatrixXd> bound_d(nc);
	//get_division(bound, bound_d, 0, (nc - 1), div_option);
	MatrixXd bound_d(dim, 2 * nc);
	get_division(bound, bound_d, nc, hyp_ls, div_option);
	for(size_t i = 0; i < nc; i++)
	{
		cregions.push_back(boost::shared_ptr<Region>
			(new Region(dataset, bound_d.middleCols(i * 2, 2))));
		cregions[i]->pregion = shared_from_this();
	}
	divide_data();
	return true;
}

/* divide samples from a region into sub-regions */
void Region::divide_data()
{
	check_invalid({cregions.empty()}, "divide_data", "sub-region should exist");
	for(size_t i = 0; i < data_idx.size(); i++)
	{
		VectorXd x;
		double y;
		get_data(data_idx[i], x, y);
		for(size_t j = 0; j < cregions.size(); j++)
		{
			MatrixXd c_bound = cregions[j]->get_bound();
			if(((x.array() >= c_bound.col(0).array()).all()) &&
				((x.array() <= c_bound.col(1).array()).all()))
			{
				cregions[j]->add_data_idx(data_idx[i]);
				break;
			}
		}
	}
}

/* add data indices (indices only) to a region */
void Region::add_data_idx(vector<size_t> idx)
{
	data_idx.insert(data_idx.end(), idx.begin(), idx.end());
}

/* add a data index (a index only) to a region */
void Region::add_data_idx(size_t idx)
{
	data_idx.push_back(idx);
}

/* get a idle region from top-to-bottom order */
boost::shared_ptr<Region> Region::get_idle_region()
{
	boost::shared_ptr<Region> idle_region = NULL;
	std::queue<boost::shared_ptr<Region>> queue;
	queue.push(shared_from_this());
	while(!queue.empty())
	{
		boost::shared_ptr<Region> r = queue.front();
		queue.pop();
		if(r->get_status() == idle)
		{
			if(!r->cregions.empty())
			{
				for(size_t i = 0; i < r->cregions.size(); i++)
				{
					queue.push(r->cregions[i]);
				}
			}
			else
			{
				idle_region = r;
				break;
			}
		}

	}
	return idle_region;
}

/* set status to a region, affecting all parent regions */
void Region::set_status(Region::status_t new_status)
{
	status = new_status;
	if(pregion)
	{
		status_t new_parent_status;
		unsigned int n_idle = 0;
		unsigned int n_busy = 0;
		unsigned int n_complete = 0;
		for(size_t i = 0; i < pregion->cregions.size(); i++)
		{
			switch(pregion->cregions.at(i)->status)
			{
				case idle:
					n_idle = n_idle + 1;
					break;
				case busy:
					n_busy = n_busy + 1;
					break;
				case complete:
					n_complete = n_complete + 1;
					break;
			}
		}
		if(n_idle != 0)
		{
			new_parent_status = idle;
		}
		else if(n_busy != 0)
		{
			new_parent_status = busy;
		}
		else 
		{
			new_parent_status = complete;
		}
		pregion->set_status(new_parent_status);
	}
}

/* get status from a region */
Region::status_t Region::get_status()
{
	return status;
}

/* get number of sub-regions */
unsigned int Region::get_num_cregions()
{
	return cregions.size();
}

/* get number of data samples */
unsigned int Region::get_num_data()
{
	return data_idx.size();
}

/* get root region */
boost::shared_ptr<Region> Region::get_root()
{
	boost::shared_ptr<Region> root = shared_from_this();
	boost::shared_ptr<Region> ptr = pregion;
	while(ptr)
	{
		root = ptr;
		ptr = ptr->pregion;
	}
	return root;
}

/* get leaf regions (bottom level sub-regions) */
vector<boost::shared_ptr<Region>> Region::get_leaf()
{
	vector<boost::shared_ptr<Region>> leaf;
	boost::shared_ptr<Region> root = get_root();
	queue<boost::shared_ptr<Region>> r_queue;
	r_queue.push(root);
	while(!r_queue.empty())
	{
		boost::shared_ptr<Region> r = r_queue.front();
		r_queue.pop();
		if(r->cregions.empty())
		{
			leaf.push_back(r);
		}
		else
		{
			for(boost::shared_ptr<Region> c: r->cregions)
			{
				r_queue.push(c);
			}
		}
	}
	return leaf;
}

void Region::set_hyp(VectorXd hypi)
{
	hyp = hypi;
};

void Region::set_hyp_ls(VectorXd hyp_lsi)
{
	hyp_ls = hyp_lsi;
};

VectorXd Region::get_hyp()
{
	return hyp;
};

VectorXd Region::get_hyp_ls()
{
	return hyp_ls;
};

void Region::write_tree()
{
	ofstream ofs("rtree.log");
	stack<boost::shared_ptr<Region> > s;	// regions
	stack<int> d;							// depth
	stack<int> p;							// peer name
	s.push(shared_from_this());
	d.push(0);
	p.push(0);
	int name = 0;
	int low_depth = 0;
	while(!s.empty())
	{
		boost::shared_ptr<Region> r = s.top();
		s.pop();
		int depth = d.top();
		d.pop();
		int curr_name = p.top();
		p.pop();
		for(size_t i = 0; i < depth; i++)
		{
			ofs << "  ";
		}

		ofs << "|-";

		ofs << "r" << curr_name;

		if(!(r->get_num_data()))
		{
			ofs << "    " << 0 << "    " << "-";
		}
		else
		{
			ofs << "    " << r->get_num_data() << "    " << r->get_min_f();
		}

		if(r->get_status() == status_t::idle)
		{
			ofs << "    " << "idle;" << endl;;
		}
		else if(r->get_status() == status_t::busy)
		{
			ofs << "    " << "busy;" << endl;;
		}
		else if(r->get_status() == status_t::complete)
		{
			ofs << "    " << "complete;" << endl;;
		}

		name += r->cregions.size();
		int n_t = name;
		for(size_t i = r->cregions.size(); i > 0; i--)
		{
			s.push(r->cregions[i - 1]);
			d.push(depth + 1);
			p.push(n_t--);
		}
	}
};

