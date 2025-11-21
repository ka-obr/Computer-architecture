.686
.model flat

public _szukaj4_max

.code

_szukaj4_max PROC
	push ebp
	mov ebp, esp

	mov eax, [ebp + 8] ;przekazujemy a

	;porownanie a z b
	cmp eax, [ebp + 12]
	jge porownajZc
	mov eax, [ebp + 12] ; wpisz b
	porownajZc:
	cmp eax, [ebp + 16]
	jge porownajZd
	mov eax, [ebp + 16]
	porownajZd:
	cmp eax, [ebp + 20]
	jge koniec
	mov eax, [ebp + 20]
	koniec:
	pop ebp
	ret
_szukaj4_max ENDP
END