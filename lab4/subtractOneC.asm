.686
.model flat

public _odejmij_jeden

.code
_odejmij_jeden PROC
	push ebp
	mov ebp, esp
	push eax
	
	mov eax, [ebp + 8] ;popieramy adres
	mov eax, [eax] ;pobieramy adres adresu
	dec dword PTR[eax] ;dekrementujemy wartosc spod adresu adresu
	pop eax
	pop ebp
	ret
_odejmij_jeden ENDP
END