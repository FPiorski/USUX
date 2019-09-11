#include "rkw.h"

void main(int argc, char* argv[])
{
	double a, b, c, delta;
	double x1, x2;
#ifdef ZESPOLONE
	double *x1z, *x2z;
#endif
	
	if (argc != 4)
	{
		printf("Poprawna skladnia:\t%s a b c\n", argv[0]);
		exit(1);
	}
	sscanf(argv[1], "%lf", &a);
	sscanf(argv[2], "%lf", &b);
	sscanf(argv[3], "%lf", &c);
	delta = Delta(a, b, c);
	if (delta >= 0)
	{
		x1 = Pierw(a, b, delta, 1);
		x2 = Pierw(a, b, delta, 2);
		printf("x1 = %lf\nx2 = %lf\n", x1, x2);
	}
	else
	{
#ifdef ZESPOLONE
		x1z = PierwZesp(a, b, delta, 1);
		x2z = PierwZesp(a, b, delta, 2);
		printf("x1 = %lf + %lfj\nx2 = %lf + %lfj\n", x1z[0], x1z[1], x2z[0], x2z[1]);
#else
		printf("Brak pierwiastkow rzeczywistych.\n");
#endif
	}
	return;
}
