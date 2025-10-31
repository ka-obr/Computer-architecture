.686
.model flat
extern _ExitProcess@4 : PROC
extern __write : PROC

.code
_wyswietl32 PROC
	push ebp
	push esi
	push edi
	push ebx
	mov esi, 0 ;licznik do maksymalnej liczby cyfr (10)

	mov ebp, esp ;przenosimy wskaznik stosu do ebp dla zmiennych lokalnych

	sub esp, 20

	mov [ebp - 4], eax ;liczba do wyswietlenia
	mov eax, 0
	mov byte PTR[ebp - 5], 10 ;dzielnik

petla:
	mov al, [ebp - 1] ;0 + 1 bajt
	mov ah, 0
	div byte PTR[ebp - 5]
	mov byte PTR[ebp - 1], al
	mov al, [ebp - 2] ; reszta 1 bajt : 2 bajt
	div byte PTR[ebp - 5]
	mov byte PTR[ebp - 2], al
	mov al, [ebp - 3] ; reszta 2 bajt : 3 bajt
	div byte PTR[ebp - 5]
	mov byte PTR[ebp - 3], al
	mov al, [ebp - 4] ; reszta 3 bajt : 4 bajt
	div byte PTR[ebp - 5]
	mov byte PTR[ebp - 4], al

	add ah, 30H ; zamiana reszty z dzielenia na kod ASCII
	neg esi
	mov [ebp + esi - 9], ah; zapisanie cyfry w kodzie ASCII ([ebp - 9] - [ebp - 19])
	neg esi
	inc esi

	;sprawdzamy czy cala liczba rowna 0
	mov bl, [ebp - 1]
	or  bl, [ebp - 2]
	jnz petla
	mov bl, [ebp - 3]
	or bl, [ebp - 4]
	jnz petla

wypeln:
	cmp esi, 12
	je wyswietl
	neg esi
	mov byte PTR [ebp + esi - 9], 20H
	neg esi
	inc esi
	jmp wypeln
wyswietl:
	lea ebx, [ebp - 20] ; dynamiczne przekazanie adresu

	push dword PTR 12
	push ebx
	push dword PTR 1
	call __write
	add esp, 32
	pop ebx
	pop edi
	pop esi
	pop ebp
	ret
_wyswietl32 ENDP

_main PROC
	mov eax, 85ADF69Ch
	call _wyswietl32

	push 0
	call _ExitProcess@4
_main ENDP
END