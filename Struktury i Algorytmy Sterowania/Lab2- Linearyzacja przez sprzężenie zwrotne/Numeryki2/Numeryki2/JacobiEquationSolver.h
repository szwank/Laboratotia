#pragma once
#include "EquationSolver.h"

class JacobiEquationSolver : EquationSolver
{
public:
	Vector solveAxEqualsB(const Matrix& A, const Vector& b) override;

	int getIterations();
private:
	int iterations = 0;;
};
