
#include "Matrix.h"
#include <iostream>
#include "GaussSiedelEquationSolver.h"
#include "GaussEquationSolver.h"
#include <ctime>
#include "JacobiEquationSolver.h"
#include <valarray>
#include <fstream>
#include <iomanip>
#include <string>
#include <regex>

#define N_SIZE 981
#define a1 3
#define a2 -1
#define a3 -1
#define f 0

double** alloc(int width, int height)
{
	double** ptr = new double*[width];
	for (int i = 0; i < width; i++)
		ptr[i] = new double[height];
	
	return ptr;
}

double bVectorValue(int position)
{
	//f is 0
	return sin(position / 50.0f);
}

void saveToFile(const Vector& gauss, double time, int* iterations, const char* filePath)
{
	std::ofstream file(filePath);
	file << time << std::endl;
	if(iterations != nullptr)
		file << *iterations << std::endl;
	file << std::setprecision(12) << std::fixed;
	for (int i = 0; i < gauss.size(); i++)
		file << gauss[i] << ' ';
	file << std::endl;
}

void calculateAndSaveToFileGaussSiedel(const Matrix& A, const Vector& b)
{
	size_t time;
	time = clock();
	GaussSiedelEquationSolver equationSolver;
	Vector gauss = equationSolver.solveAxEqualsB(A, b);
	time = clock() - time;
	double seconds = double(time) / CLOCKS_PER_SEC;
	std::cout << "gauss: " << seconds << std::endl;
	int iterations = equationSolver.getIterations();
	saveToFile(gauss, seconds, &iterations, "Gauss1000x1000.txt");
}


void calculateAndSaveToFileGauss(const Matrix& A, const Vector& b)
{
	size_t time;
	time = clock();
	GaussEquationSolver equationSolver;
	Vector gauss = equationSolver.solveAxEqualsB(A, b);
	time = clock() - time;
	double seconds = double(time) / CLOCKS_PER_SEC;
	std::cout << "gauss: " << seconds << std::endl;
	saveToFile(gauss, seconds, nullptr, "GaussDirect981x981.txt");
}

void calculateAndSaveToFileJacobi(const Matrix& A, const Vector& b)
{
	size_t time;
	time = clock();
	JacobiEquationSolver equationSolver;
	Vector jacobi = equationSolver.solveAxEqualsB(A, b);
	time = clock() - time;
	double seconds = double(time) / CLOCKS_PER_SEC;
	std::cout << "jacobi: " << seconds << std::endl;
	int iterations = equationSolver.getIterations();
	saveToFile(jacobi, seconds, &iterations, "Jacobi1000x1000.txt");
}

int main()
{


	Matrix A(N_SIZE, N_SIZE);
	A.diag(0, a1);
	A.diag(1, a2);
	A.diag(-1, a2);
	A.diag(2, a3);
	A.diag(-2, a3);
	
	Vector b(N_SIZE, bVectorValue);

	//JacobiEquationSolver().solveAxEqualsB(A, b);
	//calculateAndSaveToFileGaussSiedel(A, b);
	//calculateAndSaveToFileJacobi(A, b);


	//GaussEquationSolver().solveAxEqualsB(A, b).print();
	Vector x(N_SIZE);
	x.acceptInput();

	Vector residuum = A*x;
	residuum -= b;
	std::cout << std::setprecision(12) << residuum.norm() << std::endl;
	return 0;
}
