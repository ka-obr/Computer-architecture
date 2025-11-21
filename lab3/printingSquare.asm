.686
.model flat
extern __write : PROC
extern __read : PROC
extern _ExitProcess@4 : PROC
public _main

.data
	znaki db 5 dup (?)
	dziesiec dd 10
	output db 11 dup (?)

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

wczytaj_do_EAX PROC
		;wrzucamy rejestry ogolego przeznaczenia na stos
		push ebx
		push ecx
		push edx
		push esi
		push edi
		push ebp
		
		push dword PTR 5
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
	mov eax, 0
	call wczytaj_do_EAX
	mul eax
	call wyswietl_EAX
	push 0
	call _ExitProcess@4
_main ENDP
END