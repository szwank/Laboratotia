#pragma once
#include "EquationSolver.h"

class GaussEquationSolver : public EquationSolver
{
public:
	Vector solveAxEqualsB(const Matrix& A, const Vector& b) override;
};
