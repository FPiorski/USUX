#include "fun.h"

double Pierw(double a, double b, double delta, int flaga)
{
	if (flaga == 1)
		return (-b - sqrt(delta))/(2*a);
	else if (flaga == 2)
		return (-b + sqrt(delta))/(2*a);
}

#ifdef ZESPOLONE
double* PierwZesp(double a, double b, double delta, int flaga)
{
	double* x;

	if ((x = (double*)calloc(2, sizeof(double))) != NULL)
	{
		if (flaga == 1)
		{
			x[0] = -b/(2*a);
			x[1] = -sqrt(-delta)/(2*a);
		}
		else if (flaga == 2)
		{
			x[0] = -b/(2*a);
			x[1] = sqrt(-delta)/(2*a);
		}
		return x;
	}
	else
	{
		printf("Brak pamieci !!!\n");
		exit(2);
	}
}
#endif
