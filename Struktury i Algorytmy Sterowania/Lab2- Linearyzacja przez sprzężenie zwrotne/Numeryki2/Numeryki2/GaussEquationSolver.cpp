#include "GaussEquationSolver.h"
#include "Matrix.h"


Vector GaussEquationSolver::solveAxEqualsB(const Matrix& A, const Vector& b)
{
	A.assertSquare();
	int n = A.getWidth();
	Matrix cpy = A;
	cpy.addColumn();
	for (int i = 0; i < cpy.getHeight(); i++)
		cpy[cpy.getWidth()-1][i] = b[i];


	for (int j = 0; j<n; j++)
	{
		for (int i = 0; i<n; i++)
		{
			if (i != j)
			{
				float c = cpy[j][i] / cpy[j][j];
				for (int k = 0; k<n + 1; k++)
				{
					cpy[k][i] -= c*cpy[k][j];
				}
			}
		}
	}
	Vector x(n);
	for (int i = 0; i<n; i++)
		x[i] = cpy[n][i] / cpy[i][i];
	
	return x;
}
