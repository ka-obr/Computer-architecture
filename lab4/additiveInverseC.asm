.686
.model flat

public _liczba_przeciwna

.code
_liczba_przeciwna PROC
push ebp
    mov ebp, esp
    push ebx
    
    mov eax, [ebp + 8] 
    
    mov ebx, [eax]
    neg ebx
    mov [eax], ebx
    
    pop ebx
    pop ebp            
    
    ret
_liczba_przeciwna ENDP
END