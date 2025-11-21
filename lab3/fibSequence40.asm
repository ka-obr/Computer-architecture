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
	wyswietl_EAX PROC
		pusha
		mov esi, 11
		cmp eax, 0
		jne petla

		mov znaki[esi], '0'
		dec esi
		jmp petlaWypelnienia
		petla:
			mov edx, 0
			div dword PTR dziesiec
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
	wyswietl_EAX ENDP
	_main PROC
		mov ebx, 1
		mov ecx, 0
		mov eax, 0 
		wypisujLiczby:
			call wyswietl_EAX

			cmp ecx, 39
			je koniec

			mov edx, eax
			add eax, ebx
			mov ebx, edx
			inc ecx
			jmp wypisujLiczby
		koniec:
			push 0
			call _ExitProcess@4
	_main ENDP
END