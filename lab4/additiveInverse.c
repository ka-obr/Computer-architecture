#include <stdio.h>

void liczba_przeciwna(int* a);

int main() {
	int a;
	printf("Podaj liczbe: ");
	scanf_s("%d", &a);
	liczba_przeciwna(&a);
	printf("Liczba przeciwna do tej co podales to %d", a);
	return 0;
}