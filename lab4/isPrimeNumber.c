#include <stdio.h>

int czyLiczbaPierwsza(int liczba);

int main() {
	int liczba, wynik;
	printf("Podaj liczbe do sprawdzenia: \n");
	scanf_s("%d", &liczba);

	wynik = czyLiczbaPierwsza(liczba);
	if (wynik) {
		printf("Liczba %d jest liczba pierwsza", liczba);
	}
	else {
		printf("Liczba %d nie jest liczba piersza", liczba);
	}
	return 0;
}