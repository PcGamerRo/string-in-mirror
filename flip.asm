.model small

.stack 200h

.data
	mesaj db 13,10,'Numarul de caractere din sir este egal cu: $'
	string db 0
	nrChar db 0
.code
	start:
		mov ax, @data
		mov ds, ax
		
		mov cl, 10
		mov ch, 0
		
		;aici citesc si memorez sirul citit in "string"
		readString:
			mov ah, 01h
			int 21h
	
			cmp al, 13
			je stopCitire
						
			push ax
			
			sub al, 48
				mov bl, al
				mov al, string
				mul cl
				add al, bl
				mov string, al
			
			inc nrChar
			jmp readString
		
		;aici afisez sirul inversat cu procedura
		stopCitire:
			mov cl, nrChar
			mov ch, 0
			
			apelare:
				pop ax
				mov dl, al				
				call afisareString
			loop apelare
			; "apelare" se continua pana cand cx devine 0
		
		jmp next
	
		;procedura de afisare
		afisareString proc
			mov ah, 02h
			int 21h
		endp
		ret
			
		next:
		
		;aici afisez "Numarul de caractere din sir este egal cu:"
		mov dx, offset mesaj
		mov ah, 09h
		int 21h
		
		;aici afisez numarul de caractere
		mov al, nrChar
		mov ah, 0
				
		mov bx, 10
		xor cx, cx
	
		descompuneNr:
			xor dx, dx
			div bx
			inc cx
					
			push dx
					
			cmp ax, 0
			je afiseazaCifre
			jmp descompuneNr
		
		afiseazaCifre:
			pop dx
			add dl, 48
			mov ah, 02h
			int 21h
		loop afiseazaCifre
				
		mov ah, 4ch
		int 21h
	end
