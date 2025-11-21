#include <stdio.h>

int szukaj4_max(int a, int b, int c, int d);

int main() {
	int a, b, c, d, wynik;
	printf("Podaj prosze 4 liczby do znalezienia najwiekszej: \n");
	scanf_s("%d %d %d %d", &a, &b, &c, &d);

	wynik = szukaj4_max(a, b, c, d);

	printf("\nNajwieksza liczba sposrod podanych to %d", wynik);
}