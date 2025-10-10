; Przykład wywoływania funkcji MessageBoxA i MessageBoxW
.686
.model flat
extern _ExitProcess@4 : PROC
extern _MessageBoxA@16 : PROC
extern _MessageBoxW@16 : PROC
public _main
.data
    titleWindow dw 'Z', 'n', 'a', 'k', 'i', 0
    textWindow dw 'K', 'o', 'c', 'h', 'a', 'm', ' '
    dw 'A', 'K', 'O', ' '
    dw 0D83EH, 0DD70H, ' '
    dw 0D83DH, 0DE80H, 0
.code
_main PROC
    push 4
    push OFFSET titleWindow
    push OFFSET textWindow
    push 0
    call _MessageBoxW@16
    push 0
    call _ExitProcess@4
_main ENDP
END