/**
    UT-Dallas
    MathTestbench.hpp
    Purpose: test the DesignEasy Tool with math testbenches

    @author Zhaori Bi
    @version 1.0 2/21/2017
*/

#include "MathTestbench.hpp"
#include <chrono>
#include <iostream>
#include <string>
#include <fstream>
#include <sstream>
#include <vector>
#include <map>
#include <stdlib.h>
#include <stdio.h>
#include <iterator>
#include <time.h>
#include <math.h>
#include <random>


using namespace std;
/********************** rosenbrick function ******************************/
/* global at (x, y)=(a,a^2), f(x, y)=0 */
const double rosen(const double a, const double b, const double x, const double y){
	double result;								//	variable to store the output
	const double alph = a-x;						//	term 1
	const double beta = y-x*x;						//	term 2
	result = alph*alph + b*beta*beta;					// (a-x)^2+b(y-x^2)^2
	return result;
}
/*********************************** Ackley function ******************************/
/* global at (x, y)=(0,0), f(x, y)=0, x, y belong to (-40, 40) */
const double ackley(const double a, const double b, const double c, const double x, const double y){
	double result;								//	variable to store the output
	result=(-a)*exp(-b*sqrt(0.5*x*x+0.5*y*y))-exp(0.5*(cos(c*x)+cos(c*y)))+a+exp(1);
	return result;
}
/********************************** stright out***********************************/
const double yEx(const double x){
	double result;
	result=x;
	return result;
}
/**************** random number generated based on a specific sigma**************/
const double NormalSigma(const double x){
	double result=0;
	std::default_random_engine generator;							//	define random number generator
  	generator.seed(std::chrono::system_clock::now().time_since_epoch().count());		//	give seed based on current time
  	std::normal_distribution<double> distribution(0.0, x);					//	define a normal distribution [u=0, sigma=3]
	result=distribution(generator);
	return result;
}

