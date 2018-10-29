#include "GaussSiedelEquationSolver.h"
#include "Matrix.h"
#include <iostream>


Vector GaussSiedelEquationSolver::solveAxEqualsB(const Matrix& A, const Vector& b)
{
	Matrix copyA = A;
	Vector copyb = b;

	Matrix D = A;
	D.diag();
	Matrix LAndD = A;
	LAndD.tril();
	LAndD += D;
	Matrix U = A;
	U.triu();
	

	Vector r(A.getWidth(), (double)0);
	double epsilon = pow(10, -9);
	Matrix LAndDInversed = LAndD.inverse();
	Matrix LAndDInversedNegated = LAndDInversed;
	LAndDInversedNegated.negate();
	double norm;
	do
	{
		Vector UTimesR = U * r;
		Vector left = LAndDInversedNegated * UTimesR;

		Vector right = LAndDInversed*b;
		left += right; // left is result
		r = left;
		Vector residuum = A*r;
		residuum -= b;
		norm = residuum.norm();
		iterations++;
	} while (norm >= epsilon);

	return r;
}

int GaussSiedelEquationSolver::getIterations()
{
	return iterations;
}
