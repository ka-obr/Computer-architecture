; wczyt5ywanie i wyświetlanie tekstu wielkimi literami
; (inne znaki się nie zmieniają)
.686
.model flat
extern _ExitProcess@4 : PROC
extern __write : PROC ; (dwa znaki podkreślenia)
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
    db 'i nacisna'
    db 086H
    db ' Enter', 10
    koniec_t db ?
    magazyn db 80 dup (?)
    nowa_linia db 10
    liczba_znakow dd ?
.code
_main PROC
    mov ecx,(OFFSET koniec_t) - (OFFSET tekst_pocz)
    push ecx
    push OFFSET tekst_pocz ; adres tekstu
    push 1 ; nr urządzenia (tu: ekran - nr 1)
    call __write ; wyświetlenie tekstu początkowego
    add esp, 12 ; usuniecie parametrów ze stosu
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
        cmp dl, 086H
        je polC
        cmp dl, 0A9H
        je polE
        cmp dl, 088H
        je polL
        cmp dl, 0E4H
        je polN
        cmp dl, 0A2H
        je polO
        cmp dl, 098H
        je polS
        cmp dl, 0ABH
        je polZ
        cmp dl, 0BEH
        je polRZ
        jmp zapisz

        polA: mov dl, 0A4H
            jmp zapisz
        polC: mov dl, 08FH
            jmp zapisz
        polE: mov dl, 0A8H
            jmp zapisz
        polL: mov dl, 09DH
            jmp zapisz
        polN: mov dl, 0E3H
            jmp zapisz
        polO: mov dl, 0E0H
            jmp zapisz
        polS: mov dl, 097H
            jmp zapisz
        polZ: mov dl, 08DH 
            jmp zapisz
        polRZ: mov dl, 0BDH
            jmp zapisz

    zapisz:
        mov magazyn[ebx], dl
        inc ebx ; inkrementacja indeksu
        loop ptl ; sterowanie pętlą
    wyjscie:
        push liczba_znakow
        push OFFSET magazyn
        push 1
        call __write ; wyświetlenie przekształconego
        add esp, 12 ; usuniecie parametrów ze stosu
    push 0
    call _ExitProcess@4 ; zakończenie programu
_main ENDP
END
