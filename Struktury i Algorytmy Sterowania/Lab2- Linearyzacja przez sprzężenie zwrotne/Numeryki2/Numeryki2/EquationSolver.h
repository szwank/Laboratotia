#pragma once
#include "Vector.h"

class Matrix;

class EquationSolver
{
public:

	virtual Vector solveAxEqualsB(const Matrix& A, const Vector& b)=0;
};
