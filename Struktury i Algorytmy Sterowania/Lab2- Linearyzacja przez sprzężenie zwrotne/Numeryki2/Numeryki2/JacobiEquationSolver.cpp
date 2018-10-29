#include "JacobiEquationSolver.h"
#include "Matrix.h"

Vector JacobiEquationSolver::solveAxEqualsB(const Matrix& A, const Vector& b)
{
	double epsilon = 10e-9;
	Vector r(A.getWidth(), (double)0);
	Matrix D = A;
	D.diag();
	Matrix L = A;
	L.tril();
	Matrix U = A;
	U.triu();

	Matrix LAndU = L;
	LAndU += U;
	Matrix DInversed = D.inverse();
	Matrix DInversedTimesLAndUNegated = DInversed * LAndU;
	DInversedTimesLAndUNegated.negate();

	double norm;
	do
	{
		Vector left = DInversedTimesLAndUNegated*r;
		Vector right = DInversed*b;
		left += right; // left is now result
		r = left;
		Vector residuum = A*r;
		residuum -= b;
		norm = residuum.norm();
		iterations++;
	} while (norm >= epsilon);

	return r;
}

int JacobiEquationSolver::getIterations()
{
	return iterations;
}
