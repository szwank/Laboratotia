#pragma once

#include "Vector.h"

class Matrix
{
public:

	Matrix(int width, int height);

	Matrix(std::vector<std::vector<double>>& data);
	Matrix(double** data, int width, int height);

	Vector& operator[](int position) const;

	void operator+=(const Matrix& matrix);
	bool operator==(const Matrix& matrix);
	void operator/=(double scalar);
	void assertSameSize(const Matrix& matrix);
	void operator-=(const Matrix& matrix);
	Matrix operator*(const Matrix& matrix);
	Vector operator*(const Vector& vector) const;
	void assertSquare() const;
	void leftDivision(const Matrix& matrix);
	Matrix getTransposed(const Matrix& matrix);
	Matrix inverse() const;
	Matrix coFactor();
	double determinant();
	void negate();
	void tril();
	void triu();
	void transpose();

	void diag();
	void diag(int position, double value);
	void print() const;

	int getWidth() const;
	int getHeight() const;
	bool LUDecompose();
	Vector LUSolve(const Vector& B);
	void acceptInput();
	void addColumn();
	void addRow();
	static Matrix getUnitMatrix(int size);

private:
	std::vector<Vector> data;
};
