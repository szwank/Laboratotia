#pragma once
#include "EquationSolver.h"

class GaussSiedelEquationSolver : public EquationSolver
{
public:
	Vector solveAxEqualsB(const Matrix& A, const Vector& b) override;

	int getIterations();
private:
	int iterations = 0;;
};
