#include <stdio.h>

void przestaw(int* tablica, int n);

int main() {
	int tablica[] = {1000, 7, 6, 5, 4, 3, 2, 1};
	int rozmiar = 8;

	for (int n = rozmiar; n > 0; n--) {
		if (n == 1) {
			przestaw(tablica, n + 1);
		}
		else {
			przestaw(tablica, n);
		}
	}

	printf("Tablica po sortowaniu:\n");
	for (int i = 0; i < rozmiar; i++) {
		printf("%d ", tablica[i]);
	}
	return 0;
}