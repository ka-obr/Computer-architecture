.686
.model flat
extern __write : PROC
extern __read : PROC
extern _ExitProcess@4 : PROC
public _main

.data 
	dekoder db '0123456789ABCDEF'
	dziesiec dd 10
	znaki db 11 dup (?)

.code

wyswietl_EAX_hex PROC

	pusha

	sub esp, 12
	mov edi, esp ; adres zarezerwowanego obszaru

	mov ecx, 8 ; liczba obiegów pêtli konwersji
	mov esi, 0 ; indeks pocz¹tkowy u¿ywany przy

	ptl3hex:
		; przesuniêcie cykliczne (obrót) rejestru EAX o 4 bity w lewo
		; w szczególnoœci, w pierwszym obiegu pêtli bity nr 31 - 28
		; rejestru EAX zostan¹ przesuniête na pozycje 3 - 0
		rol eax, 4
		mov ebx, eax
		and ebx, 0000000FH
		mov dl, dekoder[ebx]

		mov [edi][esi], dl
		inc esi ;inkrementacja modyfikatora
	loop ptl3hex

	;mov byte PTR [edi][0], 10
	mov byte PTR [edi][9], 10


	push 10 ; 8 cyfr + 2 znaki nowego wiersza
	push edi ; adres obszaru roboczego
	push 1
	call __write ; wyœwietlenie

	add esp, 24

	popa
	ret
wyswietl_EAX_hex ENDP

wczytaj_do_EAX PROC
	;wrzucamy rejestry ogolego przeznaczenia na stos
	push ebx
	push ecx
	push edx
	push esi
	push edi
	push ebp
		
	push dword PTR 11
	push dword PTR OFFSET znaki
	push dword PTR 0
	call __read

	add esp, 12

	mov eax, 0
	mov ebx, OFFSET znaki
	pobieraj_znaki:
		mov cl, [ebx]

		inc ebx
		cmp cl,10
		je byl_enter
		sub cl, 30H
		movzx ecx, cl

		mul dword PTR dziesiec
		add eax, ecx
		jmp pobieraj_znaki
	byl_enter:
	; wartoœæ binarna wprowadzonej liczby znajduje siê teraz w rejestrze EAX
	;zwracamy wartosci do rejestrow
	pop ebp
	pop edi
	pop esi
	pop edx
	pop ecx
	pop ebx
	ret
wczytaj_do_EAX ENDP


_main PROC
	call wczytaj_do_EAX
	call wyswietl_EAX_hex
	push 0
	call _ExitProcess@4
_main ENDP
END

