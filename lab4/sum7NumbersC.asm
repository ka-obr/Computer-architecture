public suma_siedmiu_liczb

.code

suma_siedmiu_liczb PROC
	push rbp
	mov rbp, rsp
	push rsi
	mov rsi, 0
	
	mov rax, rcx
	add rax, rdx
	add rax, r8
	add rax, r9
	add rax, [rbp + 8*rsi + 48]
	inc rsi
	add rax, [rbp + 8*rsi + 48]
	inc rsi
	add rax, [rbp + 8*rsi + 48]

	pop rsi
	pop rbp
	ret
suma_siedmiu_liczb ENDP
END