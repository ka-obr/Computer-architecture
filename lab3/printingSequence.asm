.686
.model flat
extern __write : PROC
extern _ExitProcess@4 : PROC
public _main

.data
	znaki db 5 dup (?)
.code

	wypiszNaEkran PROC
		pusha
		push dword PTR 5
		push dword PTR OFFSET znaki
		push dword PTR 1
		call __write
		add esp, 12
		popa
		ret
	wypiszNaEkran ENDP
	wyswietl_EAX PROC
		pusha
		mov esi, 3
		petla:
			mov edx, 0
			div ebx
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
			mov byte PTR znaki[4], 20H
			call wypiszNaEkran
		popa
		ret
	wyswietl_EAX ENDP
	_main PROC
		mov ebx, 10
		mov ecx, 0
		mov eax, 1 
		wypisujLiczby:
			call wyswietl_EAX
			cmp ecx, 49
			je koniec
			inc ecx
			add eax, ecx
			jmp wypisujLiczby
		koniec:
			push 0
			call _ExitProcess@4
	_main ENDP
END