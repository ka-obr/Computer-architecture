.686
.model flat
extern _ExitProcess@4 : PROC
extern __read : PROC
public _main


.data
obszar db 12 dup (?)
dziesiec dd 10


.code
	wczytaj_do_EAX PROC
		;wrzucamy rejestry ogolego przeznaczenia na stos
		push ebx
		push ecx
		push edx
		push esi
		push edi
		push ebp
		
		push dword PTR 12
		push dword PTR OFFSET obszar
		push dword PTR 0
		call __read

		add esp, 12

		mov eax, 0
		mov ebx, OFFSET obszar
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
	wczytaj_do_EAX ENDP
	_main PROC
		call wczytaj_do_EAX
	_main ENDP
END