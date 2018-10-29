#pragma once

#include <vector>
class Matrix;

class Vector
{
public:

	Vector(int length);
	Vector(int length, double value(int position));
	Vector(int length, double defaultValue);


	double& operator[](int position) const;
	void operator+=(const Vector& vector);
	void operator-=(const Vector& vector);
	void operator=(const Vector& vector);

	int size() const;
	void print();
	double norm();
	void acceptInput();
	void addElement(double value);
private:
	std::vector<double> data;
};
