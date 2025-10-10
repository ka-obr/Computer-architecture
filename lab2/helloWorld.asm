.686
.model flat

extern _ExitProcess@4 : PROC
extern __write : PROC
public _main
.data
    tekst db 'Nazywam si', 0EAH , ' Karol ' , 10
    db 'M', 0F3H , 'j pierwszy 32-bitowy program '
    db 'asemblerowy dzia', 0B3H ,'a ju', 0BFH ,' poprawnie!', 10
.code
_main PROC
    mov ecx, 85 ; liczba znaków wyświetlanego tekstu
    push ecx ; liczba znaków wyświetlanego tekstu
    push dword PTR OFFSET tekst ; położenie obszaru
    ; ze znakami
    push dword PTR 1 ; uchwyt urządzenia wyjściowego
    call __write ; wyświetlenie znaków
    add esp, 12 ; usunięcie parametrów ze stosu
    push dword PTR 0 ; kod powrotu programu
    call _ExitProcess@4
_main ENDP
END