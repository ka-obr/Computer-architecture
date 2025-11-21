.686
.model flat

public _czyLiczbaPierwsza

.code

_czyLiczbaPierwsza PROC
	push ebp
	mov ebp, esp
	push ebx
	push ecx
	push edx

	mov ebx, [ebp + 8] ; nasza liczba do sprawdzenia

	;mov ecx, eax ; przenosimy nasza liczbe do sprawdzenia
	cmp ebx, 2
	jb koniec

	mov ecx, 2

	petla:
	mov eax, ecx
	mul ecx
	cmp eax, ebx
	ja koniec2
	mov eax, ebx
	div ecx
	cmp edx, 0
	je koniec
	inc ecx
	jmp petla


	koniec2:
	mov eax, 1

	pop edx
	pop ecx
	pop ebx
	pop ebp
	ret

	koniec:
	mov eax, 0

	pop edx
	pop ecx
	pop ebx
	pop ebp
	ret
_czyLiczbaPierwsza ENDP
END