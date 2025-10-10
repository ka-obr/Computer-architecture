; wczyt5ywanie i wyświetlanie tekstu wielkimi literami
; (inne znaki się nie zmieniają)
.686
.model flat
extern _ExitProcess@4 : PROC
extern __write : PROC ; (dwa znaki podkreślenia)
extern _MessageBoxA@16 : PROC
extern __read : PROC ; (dwa znaki podkreślenia)
public _main
.data
    tekst_pocz db 10, 'Prosz'
    db 0A9H
    db ' napisa'
    db 086H
    db ' jaki'
    db 098H
    db ' tekst '
    db 'i nacisn'
    db 0A5H
    db 086H
    db ' Enter', 10
    koniec_t db ?
    magazyn db 80 dup (?)
    nowa_linia db 10
    liczba_znakow dd ?
    tytul db 'Tekst przekonwertowany', 0
.code
_main PROC
    mov ecx,(OFFSET koniec_t) - (OFFSET tekst_pocz)
    push ecx
    push OFFSET tekst_pocz ; adres tekstu
    push 1 ; nr urządzenia (tu: ekran - nr 1)
    call __write ; wyświetlenie tekstu początkowego
    add esp, 12 ; usuniecie parametrów ze stosu
    ; czytanie wiersza z klawiatury
    push 80 ; maksymalna liczba znaków
    push OFFSET magazyn
    push 0 ; nr urządzenia (tu: klawiatura - nr 0)
    call __read ; czytanie znaków z klawiatury
    add esp, 12 ; usuniecie parametrów ze stosu

    mov liczba_znakow, eax
    ; rejestr ECX pełni rolę licznika obiegów pętli
    mov ecx, eax
    mov ebx, 0 ; indeks początkowy
    ptl: mov dl, magazyn[ebx] ; pobranie kolejnego znaku
        cmp ecx, 1
        je wyjscie
        cmp dl, 'a'
        jb sprawdzPolskie ; skok, gdy znak nie wymaga zamiany
        cmp dl, 'z'
        ja sprawdzPolskie ; skok, gdy znak nie wymaga zamiany
        sub dl, 20H ; zamiana na wielkie litery
        jmp zapisz
    sprawdzPolskie:
        cmp dl, 0A5H
        je polA
        cmp dl, 0A4H
        je polA
        cmp dl, 086H
        je polC
        cmp dl, 08FH
        je polC
        cmp dl, 0A9H
        je polE
        cmp dl, 0A8H
        je polE
        cmp dl, 088H
        je polL
        cmp dl, 09DH
        je polL
        cmp dl, 0E4H
        je polN
        cmp dl, 0E3H
        je polN
        cmp dl, 0A2H
        je polO
        cmp dl, 0E0H
        je polO
        cmp dl, 098H
        je polS
        cmp dl, 097H
        je polS
        cmp dl, 0ABH
        je polZ
        cmp dl, 08DH
        je polZ
        cmp dl, 0BEH
        je polRZ
        cmp dl, 0BDH
        je polRZ
        jmp zapisz

        polA: mov dl, 0A5H
            jmp zapisz
        polC: mov dl, 0C6H
            jmp zapisz
        polE: mov dl, 0CAH
            jmp zapisz
        polL: mov dl, 0A3H
            jmp zapisz
        polN: mov dl, 0D1H
            jmp zapisz
        polO: mov dl, 0D3H
            jmp zapisz
        polS: mov dl, 08CH
            jmp zapisz
        polZ: mov dl, 08FH 
            jmp zapisz
        polRZ: mov dl, 0AFH
            jmp zapisz

    zapisz:
        mov magazyn[ebx], dl
        inc ebx ; inkrementacja indeksu
        dec ecx
        jnz ptl
    wyjscie:
        push 0
        push OFFSET tytul
        push OFFSET magazyn
        push 0
        call _MessageBoxA@16 ; wyświetlenie przekształconego
        add esp, 12 ; usuniecie parametrów ze stosu
    push 0
    call _ExitProcess@4 ; zakończenie programu
_main ENDP
END
