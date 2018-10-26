#include "Matrix.h"
#include <iostream>

Vector::Vector(int length)
{
	data.resize(length);
}

Vector::Vector(int length, double value(int position))
{
	data.resize(length);
	for (int i = 0; i < length; i++)
		data[i] = value(i);
}

Vector::Vector(int length, double defaultValue)
{
	data.resize(length, defaultValue);
}

double& Vector::operator[](int position) const
{
	return (double&)data[position];
}

void Vector::operator+=(const Vector& vector)
{
	for (int i = 0; i < data.size(); i++)
		data[i] += vector[i];
}

void Vector::operator-=(const Vector& vector)
{
	for (int i = 0; i < data.size(); i++)
		data[i] -= vector[i];
}

void Vector::operator=(const Vector& vector)
{
	this->data = vector.data;
}

int Vector::size() const
{
	return data.size();
}

void Vector::print()
{
	for (int i = 0; i < data.size(); i++)
	{
		std::cout << data[i] << ' ';
		if (data[i] >= 0)
			std::cout << ' ';
	}
}

double Vector::norm()
{
	double sum = 0;
	for (int i = 0; i < data.size(); i++)
		sum += data[i] * data[i];
	double result = sqrt(sum);
	return result;
}

void Vector::acceptInput()
{
	for (int i = 0; i < data.size(); i++)
		std::cin >> data[i];
}

void Vector::addElement(double value)
{
	data.push_back(value);
}
