#include <iostream>
#include <ctime>

const int popSize = 50;
const int nGen = 400;
const double pCross = 0.8;
const double pMut = 0.1;
const int nVar = 3;

struct Individual
{
	double x[nVar];
	double fitness;
	double rFitness, cFitness;
};

double lower[nVar];
double upper[nVar];
Individual population[popSize];
Individual neiPopulation[popSize];
Individual bestPopulation;
using namespace std;

double randVal(double min, double max)
{
	double lidzba = (double)rand() * ((max-min)/RAND_MAX)+min;
	return lidzba;
}


Population* initialization(Individual &population)
{
	for (int i = 0; i < popSize; i++)
	{
		for (int j = 0; j < nVar; j++)
		{
			population[i].x[j] = randVal(lower[j], upper[j]);
		}
	}
	return population;
}
void ocen(Individual* population, int popSize)
{
	for (int i = 0; i < popSize; i++)
	{
		population[i].fitness = pow(population[i].x[0],2) + pow(population[i].x[1], 2) + pow(population[i].x[2], 2);
	}
}


Individual* selekcjion(Individual* population)
{
	Individual newPopulation[popSize];

	float sumaPrzystosowania = 0;
	for (int i = 0; i < popSize; i++)
	{
		sumaPrzystosowania += population[i].fitness;
	}

	population[0].cFitness = population[0].fitness;
	for (int i = 0; i <= popSize-1; i++)
	{
		population[i].cFitness = population[i - 1].cFitness + population[i].fitness;
	}
	
		for (int i = 0; i < popSize; i++)
		{
			double nowyOsobnik = randVal(0, sumaPrzystosowania);
			int j = 0;
			for (; nowyOsobnik > population[j].cFitness; j++)
			{
				
				if (j == popSize - 1)
				{
					newPopulation[i] = population[popSize - 1];
					break;
				}

			}
			newPopulation[i] = population[j];
		
		}
		return newPopulation;
}

void cross(int first, int second, Individual* population)
{
	double temp;
	int point = rand()/(nVar-1) +1
	for (int i = 0; i < point; i++)
	{
		temp = population[second].x[i];
		population[second].x[i] = population[first].x[i];
		population[first].x[i] = temp;
	}


}

void corssover(Individual* population)
{
	int one = -1;
	for (int i = 0; i < popsize; i++)
	{
		if (randVal(0, 1) < pCross)
		{
			if (one == -1)
				one = i;
		}
		else
		{
			cross(one, i);
			one = -1;
		}
	}


}

void mutation(Individual* population, double lower[], double upper[])
{
	for (int i = 0;i < popSize; i++)
	{
		for (int j = 0; j < nVar; j++)
		{
			double mutuj = randVal(0,1)
			if(mutuj<pMut)
				population[i].x[j] = randVal(lower[j], upper[j]);
		}
	}
}

int main()
{
	srand(time(NULL));

	for (int i = 0;i < nVar;i++)
	{
		lower[i] = -10;
		upper[i] = 10;
	}
	int generation = 0;

	Individual* population = new Individual[popSize];
	Individual* newpopulation = new Individual;
	initialization(population);
	ocen(population);

	while (generation < nGen)
	{
		newpopulation = selection(population);
		crossover(newpopulation);
		mutation(newpopulation);
		succesion(newpopulation, population);
		ocen(population);
		//		elitism(newpopulation);

		geneneration++;

	}

	for (int i = 0; i < nVar; i++)
	{
		cout << bestIndividual.x[i];
	}
	cout << bestIndividual.fitness;


	getchar();

	return 0;
}
