; wczytywanie i wyświetlanie tekstu wielkimi literami
; (inne znaki się nie zmieniają)
.686
.model flat
extern _ExitProcess@4 : PROC
extern _MessageBoxW@16 : PROC
extern __write : PROC ; (dwa znaki podkreślenia)
extern __read : PROC ; (dwa znaki podkreślenia)
public _main
.data
    tekst_pocz db 10, 'Prosz'
    db 0A9H
    db ' napisa'
    db 86H
    db ' jaki'
    db 98H
    db ' tekst '
    db 'i nacisn'
    db 0A5H
    db 86H
    db ' Enter', 10
    koniec_t db ?
    magazyn db 80 dup (?)
    nowa_linia db 10
    liczba_znakow dd ?
    tytul dw 'T','e','k','s','t',' '
    dw 'P', 'r', 'z', 'e', 'k', 'o', 'n', 'w', 'e', 'r', 't','o', 'w', 'a', 'n', 'y', 0
    magazynUTF dw 80 dup (?)
.code
_main PROC
    mov ecx,(OFFSET koniec_t) - (OFFSET tekst_pocz)
    push ecx
    push OFFSET tekst_pocz ; adres tekstu
    push 1 ; nr urządzenia (tu: ekran - nr 1)
    call __write ; wyświetlenie tekstu początkowego
    add esp, 12
    push 80 ; maksymalna liczba znaków
    push OFFSET magazyn
    push 0 ; nr urządzenia (tu: klawiatura - nr 0)
    call __read ; czytanie znaków z klawiatury
    add esp, 12

    mov liczba_znakow, eax
    ; rejestr ECX pełni rolę licznika obiegów pętli
    mov ecx, eax
    mov ebx, 0 ; indeks początkowy
    ptl: mov dl, magazyn[ebx] ; pobranie kolejnego znaku
        cmp ecx, 1
        je wyjscie
        cmp dl, 'a'
        jb dalej ; skok, gdy znak nie wymaga zamiany
        cmp dl, 'z'
        ja sprawdzPolskie ; skok, gdy znak nie wymaga zamiany
        sub dl, 20H ; zamiana na wielkie litery

        dalej:
            movzx ax, dl
        zapisz:
            mov magazyn[ebx], dl
            mov magazynUTF[ebx * 2], ax 
            inc ebx 
            loop ptl ; sterowanie pętlą

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
        jmp dalej

        polA: mov dl, 0A4H
            mov ax, 0104H
            jmp zapisz
        polC: mov dl, 08FH
            mov ax, 0106H
            jmp zapisz
        polE: mov dl, 0A8H
            mov ax, 0118H
            jmp zapisz
        polL: mov dl, 09DH
            mov ax, 0141H
            jmp zapisz
        polN: mov dl, 0E3H
            mov ax, 0143H
            jmp zapisz
        polO: mov dl, 0E0H
            mov ax, 00D3H
            jmp zapisz
        polS: mov dl, 097H
            mov ax, 15AH
            jmp zapisz
        polZ: mov dl, 08DH 
            mov ax, 0179H
            jmp zapisz
        polRZ: mov dl, 0BDH
            mov ax, 017BH
            jmp zapisz
    wyjscie:
        push liczba_znakow
        push OFFSET magazyn
        push 1
        call __write ; wyświetlenie przekształconego tekstu
        add esp, 12 ; usuniecie parametrów ze stosu
        push 0
        push OFFSET tytul
        push OFFSET magazynUTF
        push 0
        call _MessageBoxW@16
    push 0
    call _ExitProcess@4
_main ENDP
END
