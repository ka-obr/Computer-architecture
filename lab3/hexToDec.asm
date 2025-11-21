.686
.model flat
extern __write : PROC
extern __read : PROC
extern _ExitProcess@4 : PROC
public _main

.data
	output db 11 dup (?)
	dziesiec dd 10

.code

wypiszNaEkran PROC
	pusha
	push dword PTR 11
	push dword PTR OFFSET output
	push dword PTR 1
	call __write
	add esp, 12
	popa
	ret
wypiszNaEkran ENDP

wyswietl_EAX PROC
	pusha
	mov esi, 9
	petla:
		mov edx, 0
		div dword PTR dziesiec
		add dl, 30H
		mov output[esi], dl
		dec esi
		cmp eax, 0
		jne petla
	petlaWypelnienia:
		cmp esi, 0
		jle gotowe
		mov byte PTR output[esi], 20H
		dec esi
		jmp petlaWypelnienia
		gotowe:
			mov byte PTR output[10], 0AH
			call wypiszNaEkran
		popa
		ret
wyswietl_EAX ENDP

wczytaj_do_EAX_hex PROC
	; wczytywanie liczby szesnastkowej z klawiatury – liczba po
	; konwersji na postaæ binarn¹ zostaje wpisana do rejestru EAX
	; po wprowadzeniu ostatniej cyfry nale¿y nacisn¹æ klawisz
	; Enter
	push ebx
	push ecx
	push edx
	push esi
	push edi
	push ebp

	sub esp, 12 ; rezerwacja poprzez zmniejszenie ESP
	mov esi, esp ; adres zarezerwowanego obszaru pamiêci
	push dword PTR 9 ; max iloœæ znaków wczytyw. liczby
	push esi
	push dword PTR 0
	call __read

	add esp, 12
	mov eax, 0
	pocz_konw:
		mov dl, [esi]
		inc esi
		cmp dl, 10 ; sprawdzenie czy naciœniêto Enter
		je gotowe
		; sprawdzenie czy wprowadzony znak jest cyfr¹ 0, 1, 2 , ..., 9
		cmp dl, '0'
		jb pocz_konw
		cmp dl, '9'
		ja sprawdzaj_dalej
		sub dl, '0'
	dopisz:
		shl eax, 4 ; przesuniêcie logiczne w lewo o 4 bity
		or al, dl ; dopisanie utworzonego kodu 4-bitowego
		 ; na 4 ostatnie bity rejestru EAX
		jmp pocz_konw
		; sprawdzenie czy wprowadzony znak jest cyfr¹ A, B, ..., F
	sprawdzaj_dalej:
		cmp dl, 'A'
		jb pocz_konw
		cmp dl, 'F'
		ja sprawdzaj_dalej2
		sub dl, 'A' - 10
		jmp dopisz
		; sprawdzenie czy wprowadzony znak jest cyfr¹ a, b, ..., f
	sprawdzaj_dalej2:
		cmp dl, 'a'
		jb pocz_konw ; inny znak jest ignorowany
		cmp dl, 'f'
		ja pocz_konw ; inny znak jest ignorowany
		sub dl, 'a' - 10
		jmp dopisz
	gotowe:
		; zwolnienie zarezerwowanego obszaru pamiêci
		add esp, 12
		pop ebp
		pop edi
		pop esi
		pop edx
		pop ecx
		pop ebx
		ret
wczytaj_do_EAX_hex ENDP


_main PROC
	call wczytaj_do_EAX_hex
	call wyswietl_EAX

	push 0
	call _ExitProcess@4
_main ENDP
END