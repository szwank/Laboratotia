#include "Matrix.h"
#include <iostream>



double Determinant(Matrix& a, int n)
{
	int i, j, j1, j2;
	double det = 0;
	Matrix m(n, n);

	if (n < 1) { /* Error */

	}
	else if (n == 1) { /* Shouldn't get used */
		det = a[0][0];
	}
	else if (n == 2) {
		det = a[0][0] * a[1][1] - a[1][0] * a[0][1];
	}
	else {
		det = 0;
		for (j1 = 0; j1<n; j1++) {
			for (i = 0; i<n - 1; i++)
				for (i = 1; i<n; i++) {
					j2 = 0;
					for (j = 0; j<n; j++) {
						if (j == j1)
							continue;
						m[i - 1][j2] = a[i][j];
						j2++;
					}
				}
			det += pow(-1.0, j1 + 2.0) * a[0][j1] * Determinant(m, n - 1);
		}
	}
	return det;
}


Matrix::Matrix(int width, int height)
{
	data.resize(width, Vector(height, (double)0));
}

Matrix::Matrix(std::vector<std::vector<double>>& data)
{
	Matrix(data.size(), data[0].size());
	for (int i = 0; i < data.size(); i++)
		for (int j = 0; j < data[i].size(); j++)
			this->data[i][j] = data[i][j];
}

Matrix::Matrix(double** data, int width, int height):Matrix(width, height)
{
	for (int i = 0; i < getWidth(); i++)
		for (int j = 0; j < getHeight(); j++)
			this->data[i][j] = data[i][j];
}

Vector& Matrix::operator[](int position) const
{
	return (Vector&)data[position];
}

void Matrix::operator+=(const Matrix& matrix)
{
	assertSameSize(matrix);

	for (int i = 0; i < data.size(); i++)
		for (int j = 0; j < data[i].size(); j++)
			data[i][j] += matrix[i][j];
}

bool Matrix::operator==(const Matrix& matrix)
{
	for (int i = 0; i < data.size(); i++)
		for (int j = 0; j < data[i].size(); j++)
			if (this->data[i][j] != matrix.data[i][j])
				return false;
	return true;
}

void Matrix::operator/=(double scalar)
{
	for (int i = 0; i < data.size(); i++)
		for (int j = 0; j < data[i].size(); j++)
			this->data[i][j] /= scalar;
}

void Matrix::assertSameSize(const Matrix& matrix)
{
	if (this->getWidth() != matrix.getWidth() ||
		this->getHeight() != matrix.getHeight())
		throw std::exception("Matrixes must be the same size");
}

void Matrix::operator-=(const Matrix& matrix)
{
	assertSameSize(matrix);

	for (int i = 0; i < data.size(); i++)
		for (int j = 0; j < data[i].size(); j++)
			data[i][j] -= matrix[i][j];
}

Matrix Matrix::operator*(const Matrix& matrix)
{
	if (getWidth() != matrix.getHeight())
		throw std::exception("Cannot multiply thoose matrixes");

	Matrix result(matrix.getWidth(), this->getHeight());
	for (int i = 0; i < getHeight(); i++)
	{
		for (int j = 0; j < matrix.getWidth(); j++)
		{
			double value = 0;
			for (int k = 0; k < getWidth(); k++)
				value += data[k][i] * matrix[j][k];

			result[j][i] = value;
		}
	}
	return result;
}

Vector Matrix::operator*(const Vector& vector) const
{
	Vector v(getWidth());
	for (int i = 0; i < data[0].size(); i++)
	{
		double sum = 0;
		for (int j = 0; j < data.size(); j++)
			sum += data[j][i] * vector[j];
		v[i] = sum;
	}
	return v;
}


void Matrix::assertSquare() const
{
	if (getWidth() != getHeight())
		throw std::exception("A matrix is not square");
}

void Matrix::leftDivision(const Matrix& matrix)
{
	assertSquare();
	
	// A is lower triangular
	/*if isequal(A, A')          % A is symmetric
		[R, p] = chol(A);
	if (p == 0) % A is symmetric positive definite
		x = R \ (R' \ b); % a forward and a backward substitution
			return
			end
			[L, U, P] = lu(A);          % general, square A
			x = U \ (L \ (P*b));      % a forward and a backward substitution*/
}

Matrix Matrix::getTransposed(const Matrix& matrix)
{
	Matrix result(matrix.getHeight(), matrix.getWidth());
	for (int i = 0; i < getHeight(); i++)
		for (int j = i; j < getWidth(); j++)
			result.data[j][i] = data[i][j];
	return result;
}


Matrix Matrix::inverse() const
{
	assertSquare();
	int size = getWidth();
	Matrix A = *this;

	if(!A.LUDecompose())
		throw std::exception("Cannot inverse matrix");

	Matrix X = getUnitMatrix(size);
	
	for (int i = 0; i < A.getWidth(); i++)
		X[i] = A.LUSolve(X[i]);
	return X;
}


bool Matrix::LUDecompose()
{
	assertSquare();
	double epsilon = 10e-12;
	int size = getWidth();

	int i, j, k;
	double s;

	for (j = 0; j < size; j++)
	{
		if (fabs(data[j][j]) < epsilon) return false;
		for (i = 0; i <= j; i++)
		{
			s = 0;
			for (k = 0; k < i; k++) 
				s += data[k][i] * data[j][k];
			data[j][i] -= s;
		}
		for (i = j + 1; i < size; i++)
		{
			s = 0;
			for (k = 0; k < j; k++) 
				s += data[k][i] * data[j][k];
			data[j][i] = (data[j][i] - s) / data[j][j];
		}
	}
	return true;
}

void Matrix::acceptInput()
{
	for (int i = 0; i < data[0].size(); i++)
		for (int j = 0; j < data.size(); j++)
			std::cin >> data[j][i];
}

void Matrix::addColumn()
{
	data.push_back(data[getWidth() - 1]);
}

void Matrix::addRow()
{
	for (int i = 0; i < getWidth(); i++)
		data[i].addElement(1);
}

Vector Matrix::LUSolve(const Vector& B)
{
	assertSquare();
	double epsilon = 10e-24;
	int n = getWidth();
	Vector X(n);
	int    i, j;
	double s;
	X[0] = B[0];

	for (i = 1; i < n; i++)
	{
		s = 0;
		for (j = 0; j < i; j++) 
			s += data[j][i] * X[j];
		X[i] = B[i] - s;
	}

	if (fabs(data[n - 1][n - 1]) < epsilon)
		throw std::exception();

	X[n - 1] /= data[n - 1][n - 1];

	for (i = n - 2; i >= 0; i--)
	{
		s = 0;

		for (j = i + 1; j < n; j++) 
			s += data[j][i] * X[j];

		if (fabs(data[i][i]) < epsilon)
			throw std::exception();

		X[i] = (X[i] - s) / data[i][i];
	}
	return X;
}
Matrix Matrix::coFactor()
{
	int i, j, ii, jj, i1, j1;
	double det;
	Matrix c(getWidth(), getWidth());
	Matrix b(getWidth(), getHeight());
	for (j = 0; j<getWidth(); j++) {
		for (i = 0; i<getWidth(); i++) {

			/* Form the adjoint a_ij */
			i1 = 0;
			for (ii = 0; ii<getWidth(); ii++) {
				if (ii == i)
					continue;
				j1 = 0;
				for (jj = 0; jj<getWidth(); jj++) {
					if (jj == j)
						continue;
					c[i1][j1] = data[ii][jj];
					j1++;
				}
				i1++;
			}

			/* Calculate the determinate */
			det = Determinant(c, getWidth() - 1);

			/* Fill in the elements of the cofactor */
			b[i][j] = pow(-1.0, i + j + 2.0) * det;
		}
	}
	return b;
}



double Matrix::determinant()
{
	assertSquare();
	int i, j, j1, j2;
	double det = 0;
	int size = getWidth();
	Matrix m(size, size);

	if (size < 1) { /* Error */

	}
	else if (size == 1) { /* Shouldn't get used */
		det = data[0][0];
	}
	else if (size == 2) {
		det = data[0][0] * data[1][1] - data[1][0] * data[0][1];
	}
	else {
		det = 0;
		for (j1 = 0; j1<size; j1++) {
			for (i = 0; i<size - 1; i++)
				for (i = 1; i<size; i++) {
					j2 = 0;
					for (j = 0; j<size; j++) {
						if (j == j1)
							continue;
						m[i - 1][j2] = data[i][j];
						j2++;
					}
				}
			det += pow(-1.0, j1 + 2.0) * data[0][j1] * Determinant(m, size - 1);
		}
	}
	return det;
}

void Matrix::negate()
{
	for (int i = 0; i < data.size(); i++)
		for (int j = 0; j < data[i].size(); j++)
			data[i][j] = -data[i][j];
}

void Matrix::tril()
{
	assertSquare();

	for (int i = 0; i < getHeight(); i++)
		for (int j = i; j < getWidth(); j++)
			data[j][i] = 0;
}

void Matrix::triu()
{
	assertSquare();
	for (int i = 0; i < getHeight(); i++)
		for (int j = i; j < getWidth(); j++)
			data[i][j] = 0;
}

void Matrix::transpose()
{
	assertSquare();
	int i, j;
	double tmp;

	for (i = 1; i<getWidth(); i++) {
		for (j = 0; j<i; j++) {
			tmp = data[i][j];
			data[i][j] = data[j][i];
			data[j][i] = tmp;
		}
	}
}

void Matrix::diag()
{
	assertSquare();
	for (int i = 0; i < getHeight(); i++)
		for (int j = 0; j < getWidth(); j++)
			if (i != j)
				data[i][j] = 0;
}

void Matrix::diag(int position, double value)
{
	assertSquare();
	if(position >= 0)
	{
		int x = position;
		for (int i = 0; i < getHeight() - position; i++)
		{
			data[x][i] = value;
			x++;
		}
	}
	else
	{
		position = -position;
		int y = position;
		for (int i = 0; i < getWidth() - position; i++)
		{
			data[i][y] = value;
			y++;
		}
	}
}

void Matrix::print() const
{
	for (int i = 0; i < data[0].size(); i++)
	{
		for (int j = 0; j < data.size(); j++)
		{
			std::cout << data[j][i] << ' ';
			if (data[j][i] >= 0)
				std::cout << ' ';
		}
		std::cout << std::endl;
	}
}

int Matrix::getWidth() const
{
	return data.size();
}

int Matrix::getHeight() const
{
	return data[0].size();
}

Matrix Matrix::getUnitMatrix(int size)
{
	Matrix result(size, size);
	for (int i = 0; i < size; i++)
		result[i][i] = 1;
	return result;
}
