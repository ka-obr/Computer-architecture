.686
.model flat
extern __write : PROC
extern _ExitProcess@4 : PROC
public _main

.data
	znaki db 13 dup (?)
	dziesiec dd 10
.code

	wypiszNaEkran PROC
		pusha
		push dword PTR 13
		push dword PTR OFFSET znaki
		push dword PTR 1
		call __write
		add esp, 12
		popa
		ret
	wypiszNaEkran ENDP
	wyswietl_EBXEAX PROC
		pusha
		mov esi, 11
		cmp ebx, 0
		jne petla
		cmp eax, 0
		jne petla

		mov znaki[esi], '0'
		dec esi
		jmp petlaWypelnienia
		petla:
			mov edx, 0
			cmp ebx, 0 ; jesli liczba nie jest zapisana na 2 rejestrach
			je skok
			push eax ;zostawiamy dolna czesc liczby na potem
			mov eax, ebx ;bedziemy dzielic gorna czesc liczby

			div dword PTR dziesiec ; rejestr edx ma teraz nasza reszte
			mov ebx, eax
			pop eax
		skok:
			div dword PTR dziesiec ;jezeli dzielimy liczbe >32-bit to dzielimy EDX:EAX
			add dl, 30H
			mov znaki[esi], dl
			dec esi
			cmp eax, 0
			jne petla
		petlaWypelnienia:
			cmp esi, 0
			jl gotowe
			mov byte PTR znaki[esi], 20H
			dec esi
			jmp petlaWypelnienia
		gotowe:
			mov byte PTR znaki[12], 0AH
			call wypiszNaEkran
		popa
		ret
	wyswietl_EBXEAX ENDP
	_main PROC
	;	EBX:EAX = F(n)
		mov eax, 0
		mov ebx, 0
	;	EDX:ECX = F(n-1)
		mov edx, 0
		mov ecx, 1

		;licznik petli
		mov edi, 0
		wypisujLiczby:
			call wyswietl_EBXEAX

			cmp edi, 59
			je koniec

		;	tymczasowo na stos zeby potem przepisac
			push ebx
			push eax

		;	Przesuwamy siê do nastêpnego wyrazu
			add eax, ecx
			adc ebx, edx

		; popujemy ze stosu od razu przy okazji przepisuj¹c wartoœæ FIB

			pop ecx
			pop edx

			inc edi
			jmp wypisujLiczby
		koniec:
			push 0
			call _ExitProcess@4
	_main ENDP
END