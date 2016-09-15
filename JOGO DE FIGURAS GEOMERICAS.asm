.MODEL SMALL
.STACK 100H
.DATA
INICIO      DB      0Ah,0Dh,'  Ana Luisa Bavati -  RA:13022165', 0DH, 0AH, '  Julia Coelho Furlani - RA:13027958$'
INICIO1     DB      0Ah,0Dh,'----- JOGO DE FIGURAS GEOMERICAS ---- $'
INICIO2     DB      0Ah,0Dh,'PRESSIONE QUALQUER TECLA  PARA CONTINUAR                    ...$'
X           DW       ?
X_FINAL     DW       ?
Y           DW       ?
Y_FINAL     DW       ?
CORV        DB       ?
VALOR       DW       ?
NUM			DW		 0
NUM2		DW		 0
LO			DW       0
COR_1       DB       ?
COR_2       DB       ?
SOLIDOS_1   DB      ?
SOLIDOS_2   DB      ?
REGRA       DB      0Ah,0Dh,'   No jogo, na parte superior da tela', 0DH, 0AH,'       teremos 2 figuras $'
REGRA1      DB      0Ah,0Dh,'   Na parte inferior da tela ,teremos', 0DH, 0AH, '      4 figuras,representadas por: ', 0DH, 0AH,'              A ,B, C, e D$'
REGRA2      DB      0Ah,0Dh,'Voce devera digitar  primeiro o numero ', 0DH, 0AH,'da figura e dpois a letra que  ', 0DH, 0AH,'corresponde a resposta correta. $'
SOLIDOSV    DB       ?
CORVV		DB		 ?
COMP		DB		 ?
RESPOSTA1   DB       ?
RESPOSTA2   DB       ?
ERRO        DW       0
ACERTO      DW       0
LUGAR       DB       ?
CONT        DB       0
SOLI        DB       0
CORE         DB       0
ACERTOU      DB    0DH, 0AH,' ', 0DH, 0AH,'------------ VOCE ACERTOU !! -----------$'
ERROU      DB    0DH, 0AH,' ', 0DH, 0AH,'------------- VOCE ERROU !! -----------$'
PERDEU      DB    0DH, 0AH,' ', 0DH, 0AH,'------------- VOCE PERDEU !! -----------$'
opcao_FINAL    DB     0Ah,0Dh,'Deseja jogar novamente?(s/n) $'
GANHOU      DB    0DH, 0AH,' ', 0DH, 0AH,'------------- VOCE GANHOU !! -----------$'
PRIMEIRA      DB    0DH, 0AH,' ', 0DH, 0AH,'Digite a resposta da primeira figura :', 0DH, 0AH,'            (A , B , C OU D) $'
segunda        DB    0DH, 0AH,' ', 0DH, 0AH,'------------ VOCE ACERTOU !! -----------', 0DH, 0AH,' Digite a resposta da segunda figura :', 0DH, 0AH,'          (A , B , C OU D) $'
opcao      db   ?
ACC       DB ?
PRINT_ACERTOS         DB    0DH, 0AH,' ACERTOS: :$'
PRINT_ERROS       DB    0DH, 0AH,' ERROS: :$'
SCORE1          DB      0DH, 0AH,' ', 0DH, 0AH,'---------------------------------------$'
SCORE          DB      0DH, 0AH,' ', 0DH, 0AH,'-------------- *PLACAR* ---------------$'
SCORE2          DB      0DH, 0AH,' ', 0DH, 0AH,'---------------------------------------$'
.CODE
MAIN PROC
        MOV AX, @DATA  ;CARREGAR DATA
		MOV DS, AX
mov ah,00h 
mov al,04h
int 10h
mov ah,11
mov bh,0
mov bl,6 ; cor da pagina
int 10h
mov ah,11
mov bh,1
mov bl,6 ;cor da LETRA
int 10h

	CALL INICIO_1
 
     mov ah,1 ;CONTINUAR... 
     int 21h
	 
	 mov al, 13h ; seta modo de video
	 mov ah, 0
	 int 10h
	 
	   LEA 	DX,PRIMEIRA
		MOV     AH,9H
		INT 	21H
	 
	 MOV AH,2H    ; PULAR LINHA 
		MOV DL,0DH
		INT 21H
		MOV DL,0AH
		INT 21H
		
		MOV AH,2H    ; PULAR LINHA 
		MOV DL,0DH
		INT 21H
		MOV DL,0AH
		INT 21H
		
		LEA 	DX,INICIO2   ;TERCEIRA FRASE
		MOV     AH,9H
		INT 	21H
		
		mov ah,1 ;CONTINUAR... 
     int 21h
	 
	 mov al, 13h ; seta modo de video
	 mov ah, 0
	 int 10h
	
	; dividir a tela
	CALL DIV_TELA
	
	; parte SUPERIOR
	
	 MOV X,65   
	 MOV X_FINAL,125
	 MOV Y,5  
	 MOV Y_FINAL,65
	 CALL COR	
	 MOV CL,CORV
	 MOV COR_1,CL
     CALL SOLIDOS
	 MOV CL,SOLIDOSV
	 MOV SOLIDOS_1,CL
	 INC NUM
	 ADD NUM2, 3
	 
	 CALL SLEEP
	 CALL SLEEP
	 
	 MOV X,185   
	 MOV X_FINAL,245
	 MOV Y,5  
	 MOV Y_FINAL,65
	 CALL COR	
	 MOV CL,CORV
	 MOV COR_2,CL
     CALL solidos
	 MOV CL,SOLIDOSV
     MOV SOLIDOS_2,CL
	 INC NUM
	 ADD NUM2, 3
	 
	CALL PRIMEIRA_FIGURA
   

MOV AH,4CH
INT 21H
MAIN ENDP
;--------------------------------------------------
PRIMEIRA_FIGURA PROC 
     MOV BL, COR_1
	 MOV CORE, BL
	 
	 MOV BL, SOLIDOS_1
	 MOV SOLI, BL
	 
	CALL LUGAR_INFERIOR

     MOV AH,1H 
	 INT 21H
	 MOV RESPOSTA1, AL
	 
	 MOV BL, RESPOSTA1

CMP LUGAR, BL
JE ACERR

CMP LUGAR, BL
JNE ERRR

ACERR: CALL ACERTOS_1
       JMP FIM_SOLT1

ERRR: CALL ERRO_1
	  JMP FIM_SOLT1

FIM_SOLT1:
RET
PRIMEIRA_FIGURA ENDP
;-----------------------------------
ERRO_1 PROC
add ERRO,1
CALL TELA_ERROU
     CALL SLEEP
	 CALL SLEEP
	  CALL SLEEP
	 CALL SLEEP
     CALL SLEEP
	 CALL SLEEP
	 

CALL PARTE_SUPERIOR_DEFINIDA

 MOV BL, COR_1
	 MOV CORE, BL
	 
	 MOV BL, SOLIDOS_1
	 MOV SOLI, BL
	 
	CALL LUGAR_INFERIOR

     MOV AH,1H 
	 INT 21H
	 MOV RESPOSTA1, AL
	 
	 MOV BL, RESPOSTA1

CMP LUGAR, BL
JE ACERR1

CMP LUGAR, BL
JNE ERRR1

ACERR1: CALL ACERTOS_1
       JMP FIM_SOLT11

ERRR1: 
add ERRO,1
CALL TELA_PERDEU
	  

FIM_SOLT11:
RET

ERRO_1 ENDP
;---------------------------------
ACERTOS_1 PROC
add ACERTO,1
CALL TELA_ACERTOU
CALL SLEEP
CALL SLEEP
CALL SLEEP
CALL SLEEP
CALL PINTAR_SOLIDO1
 
mov al, 13h ; seta modo de video
	 mov ah, 0
	 int 10h
	 
	   LEA 	DX,segunda
		MOV     AH,9H
		INT 	21H
	 
	 MOV AH,2H    ; PULAR LINHA 
		MOV DL,0DH
		INT 21H
		MOV DL,0AH
		INT 21H
		
		MOV AH,2H    ; PULAR LINHA 
		MOV DL,0DH
		INT 21H
		MOV DL,0AH
		INT 21H
		
		LEA 	DX,INICIO2   ;TERCEIRA FRASE
		MOV     AH,9H
		INT 	21H
		
		mov ah,1 ;CONTINUAR... 
     int 21h

	 CALL SEGUNDA_PARTE


ACERTOS_1 ENDP
;----------------------------------------------
SEGUNDA_PARTE PROC

CALL PARTE_SUPERIOR_DEFINIDA
CALL PINTAR_SOLIDO1

 MOV BL, COR_2
	 MOV CORE, BL
	 
	 MOV BL, SOLIDOS_2
	 MOV SOLI, BL
	 
	CALL LUGAR_INFERIOR

     MOV AH,1H 
	 INT 21H
	 MOV RESPOSTA1, AL
	 
	 MOV BL, RESPOSTA1

CMP LUGAR, BL
JE ACERR2

CMP LUGAR, BL
JNE ERRR2

ACERR2: CALL ACERTOS_2
       JMP FIM_SOLT12

ERRR2: CALL ERRO_2
	  JMP FIM_SOLT12

FIM_SOLT12:
RET

SEGUNDA_PARTE ENDP
;---------------------------------------------------------------------
ACERTOS_2 PROC
add ACERTO,1

CALL TELA_GANHOU


ACERTOS_2 ENDP
;--------------------------------------------------------------------
ERRO_2 PROC

add ERRO,1
CALL TELA_ERROU
     CALL SLEEP
	 CALL SLEEP
	  CALL SLEEP
	 CALL SLEEP
     CALL SLEEP
	 CALL SLEEP
	 

CALL PARTE_SUPERIOR_DEFINIDA
CALL PINTAR_SOLIDO1 

 MOV BL, COR_2
	 MOV CORE, BL
	 
	 MOV BL, SOLIDOS_2
	 MOV SOLI, BL
	 
	CALL LUGAR_INFERIOR

     MOV AH,1H 
	 INT 21H
	 MOV RESPOSTA1, AL
	 
	 MOV BL, RESPOSTA1

CMP LUGAR, BL
JE ACERR12

CMP LUGAR, BL
JNE ERRR12

ACERR12: CALL ACERTOS_2
       JMP FIM_SOLT112

ERRR12: 
add ERRO,1
CALL TELA_PERDEU
	  

FIM_SOLT112:
RET



ERRO_2 ENDP
;--------------------------------------------------------------------------------------
APAGAR_PARTE_INFERIOR PROC
mov ah,0ch   ;print pixel por pixel 
mov al,0 ;escolhendo a  cor - PRETO
 MOV X,0   
	 MOV X_FINAL,320
	 MOV Y,110  
	 MOV Y_FINAL,200
MOV CX,X  ;horizontal -- eixo x T
MOV DX,Y  ;vertical   -- eixo yT
	 
 FP: int 10h
inc dx
cmp dx,Y_FINAL
jne FP
mov dx,Y
inc cx
cmp cx,X_FINAL
jne FP
RET
APAGAR_PARTE_INFERIOR ENDP
;------------------------------------------------------------------------------------
INICIO_1 PROC
 LEA 	DX,INICIO  ;PRIMEIRA FRASE
		MOV     AH,9H
		INT 	21H
		
		MOV AH,2H    ; PULAR LINHA 
		MOV DL,0DH
		INT 21H
		MOV DL,0AH
		INT 21H
		
		MOV AH,2H    ; PULAR LINHA 
		MOV DL,0DH
		INT 21H
		MOV DL,0AH
		INT 21H
		LEA 	DX,INICIO1     ;SEGUNDA FRASE:
		MOV     AH,9H
		INT 	21H
		
		MOV AH,2H    ; PULAR LINHA 
		MOV DL,0DH
		INT 21H
		MOV DL,0AH
		INT 21H
		
		MOV AH,2H    ; PULAR LINHA 
		MOV DL,0DH
		INT 21H
		MOV DL,0AH
		INT 21H
		
		LEA 	DX,regra
		MOV     AH,9H
		INT 	21H
		
		MOV AH,2H    ; PULAR LINHA 
		MOV DL,0DH
		INT 21H
		MOV DL,0AH
		INT 21H
		
		LEA 	DX,regra1
		MOV     AH,9H
		INT 	21H
		
		MOV AH,2H    ; PULAR LINHA 
		MOV DL,0DH
		INT 21H
		MOV DL,0AH
		INT 21H
		
		
		
		MOV AH,2H    ; PULAR LINHA 
		MOV DL,0DH
		INT 21H
		MOV DL,0AH
		INT 21H
		
		MOV AH,2H    ; PULAR LINHA 
		MOV DL,0DH
		INT 21H
		MOV DL,0AH
		INT 21H
		MOV AH,2H    ; PULAR LINHA 
		MOV DL,0DH
		INT 21H
		MOV DL,0AH
		INT 21H
		
		MOV AH,2H    ; PULAR LINHA 
		MOV DL,0DH
		INT 21H
		MOV DL,0AH
		INT 21H
		
		MOV AH,2H    ; PULAR LINHA 
		MOV DL,0DH
		INT 21H
		MOV DL,0AH
		INT 21H
		
		MOV AH,2H    ; PULAR LINHA 
		MOV DL,0DH
		INT 21H
		MOV DL,0AH
		INT 21H
		
		LEA 	DX,INICIO2   ;TERCEIRA FRASE
		MOV     AH,9H
		INT 	21H
		
RET
INICIO_1 ENDP
;------------------------------------------------------------------------------------
SLEEP PROC
	
MOV DX,0
MOV AX,0
INICIO_SLEEP:
INC AX
CMP AX,10
JNE INICIO_SLEEP
INC DX
CMP DX,2
JNE INICIO_SLEEP	
RET
SLEEP ENDP
;--------------------------------------------------------------------------------------
RANDOM PROC
  MOV AH, 00h  ; interrupts to get system time        
   INT 1AH      ; CX:DX now hold number of clock ticks since midnight      
   
   mov  ax, dx
   xor  dx, dx
   mov  cx, 5
   div  cx       ; here dx contains the remainder of the division - from 0 to 9  

RET
 
 RANDOM ENDP
;-------------------------------------------------------------------------------------
div_tela proc
PUSH AX
PUSH BX
PUSH CX
PUSH DX
 ;div tela
     mov ah,0ch   ;cor
     mov al,0011b 
    
mov x_final,320
	mov dx,100
	mov cx,0

div_cont:int 10h
	inc cx
	cmp cx,320
	jne div_cont
	
	
	 MOV X,155   
	 
	 MOV Y,0
	 MOV Y_FINAL,100
	 mov cx,x
	 mov dx,y
	 div_cont1:int 10h
	inc dx
	cmp dx,y_final
	jne div_cont1
	
	
	
POP DX
POP CX
POP BX
POP AX
RET
div_tela ENDP
;---------------------------------------------------------
SOLIDOS PROC
CALL RANDOM
ADD DX, NUM 

CMP DX,0
JE QUADRADO1  

CMP DX,1
JE RETANGULO1

CMP DX,2
JE RETANGULO21

CMP DX,3
JE TRIANGULO1

CMP DX,4
JE TRIANGULO21


QUADRADO1:
MOV SOLIDOSV, DL
mov ah,0ch
MOV AL,CORVV
CALL QUADRADO 
JMP FIMM

RETANGULO1:
MOV SOLIDOSV, DL
mov ah,0ch
 MOV AL,CORVV
 CALL RETANGULO
 JMP FIMM
 
RETANGULO21:
MOV SOLIDOSV, DL
mov ah,0ch
  MOV AL,CORVV
 CALL RETANGULO2
JMP FIMM

TRIANGULO1:
MOV SOLIDOSV, DL
mov ah,0ch
  MOV AL,CORVV
  CALL TRIANGULO
JMP FIMM

TRIANGULO21:
MOV SOLIDOSV, DL
mov ah,0ch
MOV AL,CORVV
CALL TRIANGULO2
JMP FIMM
MOV DX,0
FIMM: RET

SOLIDOS ENDP
;--------------------------------------------------------------------------------------
COR PROC
CALL RANDOM
CMP DX,0
JE COR1
CMP DX,1
JE COR2
CMP DX,2
JE COR3
CMP DX,3
JE COR4
CMP DX,4
JE COR5

 
  COR1:  MOV CORV, DL
		 mov ah,0ch   ;print pixel por pixel 
	     mov al,0001b ;escolhendo a  cor - azul
		 MOV CORVV, AL
		 JMP FIM
		 
  COR2:  MOV CORV, DL
		 mov ah,0ch   ;print pixel por pixel 
	     mov al,0010b ;escolhendo a  cor - verde
		 MOV CORVV, AL
		 JMP FIM
		 
 COR3:  MOV CORV, DL
		mov ah,0ch   ;print pixel por pixel 
	    mov al,0100b ;escolhendo a  cor VERMELHO
		MOV CORVV, AL
		JMP FIM
		
				 
 COR4:  MOV CORV, DL
		mov ah,0ch   ;print pixel por pixel 
	    mov al,0101b ;escolhendo a  cor rosa
		MOV CORVV, AL
		JMP FIM
		
COR5:   MOV CORV, DL
		mov ah,0ch   ;print pixel por pixel 
	    mov al,0011b ;escolhendo a  cor -
		MOV CORVV, AL
		JMP FIM	
		
		
	FIM:RET 	 
COR ENDP
;---------------------------------------------
QUADRADO PROC
PUSH AX
PUSH BX
PUSH CX
PUSH DX
    
    MOV CX,X  ;horizontal -- eixo x T
	MOV DX,Y  ;vertical   -- eixo yT
	 
    s1:int 10h
	inc cx
	cmp cx,X_FINAL
	jne s1
	
	s2:	int 10h
	
	inc dx
	cmp dx,Y_FINAL
	jne s2
	s3:	int 10h
	dec cx
	cmp cx,X
	jne s3
	
	s4:	int 10h
	dec dx
	cmp dx,Y
    JE SAIR_QUADRADO_SOLIDO
	JMP S4
SAIR_QUADRADO_SOLIDO:
POP DX
POP CX
POP BX
POP AX
RET
QUADRADO ENDP
;------------------------------------
RETANGULO PROC
PUSH AX
PUSH BX
PUSH CX
PUSH DX
 
    MOV CX,X  ;horizontal -- eixo x 
	
	MOV DX,Y  ;vertical   -- eixo y
    
	SUB Y_FINAL,30
	
	s11:int 10h
	inc cx
	cmp cx,X_FINAL
	jne s11
	
	s12:int 10h
	inc dx
	cmp dx,Y_FINAL
	jne s12
	s13:int 10h
	dec cx
	cmp cx,X
	jne s13
	
	s14:	int 10h
	dec dx
	cmp dx,Y
	JE SAIR_RETANGULO
	jmp s14
	SAIR_RETANGULO:
POP DX
POP CX
POP BX
POP AX
RET
RETANGULO ENDP
;-------------------------------------
RETANGULO2 PROC
PUSH AX
PUSH BX
PUSH CX
PUSH DX
    MOV CX,X  ;horizontal -- eixo x 
	MOV DX,Y  ;vertical   -- eixo y
    SUB X_FINAL,30
	
	s21:int 10h
	inc Dx
	cmp Dx,Y_FINAL
	jne s21
	
	s22:int 10h
	inc Cx
	cmp Cx,X_FINAL
	jne s22
	s23:int 10h
	dec Dx
	cmp Dx,Y
	jne s23
	
	s24:	int 10h
	dec Cx
	cmp Cx,X
	jne s24
POP DX
POP CX
POP BX
POP AX
RET
RETANGULO2 ENDP
;--------------------------------------
TRIANGULO PROC
PUSH AX
PUSH BX
PUSH CX
PUSH DX
  
  
    MOV CX,X_final  ;horizontal -- eixo x 
	MOV DX,Y_FINAL  ;vertical   -- eixo y
  
 TRI121:
       INT 10H
       DEC CX 
	   CMP CX,X
       JNE TRI121
	
	  	  
	   TRI221: INT 10H
       INC CX 
	   DEC DX
       CMP CX,X_FINAL
       JNE P121
      P121:CMP DX,Y
	    JNE TRI221
		 
	TRI321: INT 10H
	   INC DX
       CMP DX,Y_FINAL
	   JNE TRI321
		 
	
		 JMP SAIR_TRIANGULO2
	 
	 
	 
	 
SAIR_TRIANGULO:	
POP DX
POP CX
POP BX
POP AX
	RET
TRIANGULO ENDP	
;----------------------------------------
TRIANGULO2 PROC
PUSH AX
PUSH BX
PUSH CX
PUSH DX
 
    MOV CX,X  ;horizontal -- eixo x 
	MOV DX,Y  ;vertical   -- eixo y
  
 TRI12:
       INT 10H
       INC CX 
	   CMP CX,X_FINAL
       JNE TRI12
	
	  	  
	   TRI22: INT 10H
       DEC CX 
	   INC DX
       CMP CX,X
       JNE P12
      P12:CMP DX,Y_FINAL
	    JNE TRI22
		 
	TRI32: INT 10H
	   DEC DX
       CMP DX,Y
	   JNE TRI32
		 
	
		 JMP SAIR_TRIANGULO2
      
	SAIR_TRIANGULO2:
POP DX
POP CX
POP BX
POP AX
	RET
TRIANGULO2 ENDP	
;-----------------------------------------------------------
LUGAR_INFERIOR PROC
vl_LUGAR_INFERIOR:
CALL RANDOM
CMP DX, 0
JE PRIMEIRA_POSICAO

CMP DX, 1
JE SEGUNDA_POSICAO

CMP DX, 2
JE TERCEIRA_POSICAO

CMP DX, 3
JE QUARTA_POSICAO

CMP DX, 4
JE call_random

call_random:jmp vl_LUGAR_INFERIOR

PRIMEIRA_POSICAO: CALL POSICAO1
JMP FIM43
SEGUNDA_POSICAO: CALL POSICAO2
JMP FIM43
TERCEIRA_POSICAO: CALL POSICAO3
JMP FIM43
QUARTA_POSICAO: CALL POSICAO4
JMP FIM43
FIM43: RET
LUGAR_INFERIOR ENDP
;--------------------------------------------------------------------
POSICAO1 PROC
MOV LUGAR, 'a'
;1
	 MOV X,10   
	 MOV X_FINAL, 70
	 MOV Y,120  
	 MOV Y_FINAL,180
	 CALL COR_DEFINIDA	
     CALL SOLIDOS_COLORIDOS_DEFINIDA
	 ADD NUM, 1
	 ADD NUM2, 3
;2
	 
	 CALL SLEEP
	 CALL SLEEP
	 
	 MOV X,85   
	 MOV X_FINAL,145
	 MOV Y,120  
	 MOV Y_FINAL,180
	 CALL COR	
	 CALL solidos_coloridos
	 ADD NUM, 1
	 ADD NUM2, 3

;3
	 
	 CALL SLEEP
	 CALL SLEEP 
	  mov dx,0
	 
	 MOV X,155   
	 MOV X_FINAL,215
	 MOV Y,120  
	 MOV Y_FINAL,180
	 CALL COR	
	 CALL solidos_coloridos
	 ADD NUM, 1
	 ADD NUM2, 3
	 
	CALL SLEEP
	CALL SLEEP 
	 mov dx,0
;4
	 
	 MOV X, 225   
	 MOV X_FINAL,285
	 MOV Y,120  
	 MOV Y_FINAL,180
	 CALL COR	
	 CALL solidos_coloridos
	 ADD NUM, 1
	 ADD NUM2, 3
RET
POSICAO1 ENDP
;-----------------------------------------------------------
POSICAO2 PROC
MOV LUGAR, 'b'
;1
	 MOV X,10   
	 MOV X_FINAL, 70
	 MOV Y,120  
	 MOV Y_FINAL,180
	 CALL COR	
	 CALL solidos_coloridos
	 ADD NUM, 1
	 ADD NUM2, 3
	 
	 CALL SLEEP
	 CALL SLEEP
;2
	 MOV X,85   
	 MOV X_FINAL,145
	 MOV Y,120  
	 MOV Y_FINAL,180
	 CALL COR_DEFINIDA	
     CALL SOLIDOS_COLORIDOS_DEFINIDA
	 ADD NUM, 1
	 ADD NUM2, 3
	 
	 CALL SLEEP
	 CALL SLEEP 
	  mov dx,0
;3
	 MOV X,155   
	 MOV X_FINAL,215
	 MOV Y,120  
	 MOV Y_FINAL,180
	 CALL COR	
	 CALL solidos_coloridos
	 ADD NUM, 1
	 ADD NUM2, 3
	 
	 CALL SLEEP
	 CALL SLEEP 
	 mov dx,0
;4
	 MOV X, 225   
	 MOV X_FINAL,285
	 MOV Y,120  
	 MOV Y_FINAL,180
	 CALL COR	
	 CALL solidos_coloridos
	 ADD NUM, 1
	 ADD NUM2, 3
RET
POSICAO2 ENDP
;-----------------------------------------------------------
POSICAO3 PROC
MOV LUGAR, 'c'
;1
	 MOV X,10   
	 MOV X_FINAL, 70
	 MOV Y,120  
	 MOV Y_FINAL,180
	 CALL COR	
	 CALL solidos_coloridos
	 ADD NUM, 1
	 ADD NUM2, 3
	 
	 CALL SLEEP
	 CALL SLEEP
;2
	 MOV X,85   
	 MOV X_FINAL,145
	 MOV Y,120  
	 MOV Y_FINAL,180
	 CALL COR	
	 CALL solidos_coloridos
	 ADD NUM, 1
	 ADD NUM2, 3
	 
	 CALL SLEEP
	 CALL SLEEP 
	  mov dx,0
;3
	 MOV X,155   
	 MOV X_FINAL,215
	 MOV Y,120  
	 MOV Y_FINAL,180
	 CALL COR_DEFINIDA	
     CALL SOLIDOS_COLORIDOS_DEFINIDA
	 ADD NUM, 1
	 ADD NUM2, 3
	 
	CALL SLEEP
	CALL SLEEP 
	 mov dx,0
;4
	 MOV X, 225   
	 MOV X_FINAL,285
	 MOV Y,120  
	 MOV Y_FINAL,180
	 CALL COR	
	 CALL solidos_coloridos
	 ADD NUM, 1
	 ADD NUM2, 3
RET
POSICAO3 ENDP
;-----------------------------------------------------------
POSICAO4 PROC
MOV LUGAR, 'd'
;1
	 MOV X,10   
	 MOV X_FINAL, 70
	 MOV Y,120  
	 MOV Y_FINAL,180
	 CALL COR	
	 CALL solidos_coloridos
	 ADD NUM, 1
	 ADD NUM2, 3
	 
	 CALL SLEEP
	 CALL SLEEP
;2
	 MOV X,85   
	 MOV X_FINAL,145
	 MOV Y,120  
	 MOV Y_FINAL,180
	 CALL COR	
	 CALL solidos_coloridos
	 ADD NUM, 1
	 ADD NUM2, 3
	 
	 CALL SLEEP
	 CALL SLEEP 
	  mov dx,0
;3
	 MOV X,155   
	 MOV X_FINAL,215
	 MOV Y,120  
	 MOV Y_FINAL,180
	 CALL COR	
	 MOV DL, COMP
	 CALL solidos_coloridos
	 ADD NUM, 1
	 ADD NUM2, 3
	 
	CALL SLEEP
	CALL SLEEP 
	 mov dx,0
;4
	 MOV X, 225   
	 MOV X_FINAL,285
	 MOV Y,120  
	 MOV Y_FINAL,180
	 CALL COR_DEFINIDA	
     CALL SOLIDOS_COLORIDOS_DEFINIDA
RET
POSICAO4 ENDP
;--------------------------------------------------------------
SOLIDOS_COLORIDOS PROC
CC:call sleep
CALL RANDOM

	CMP DL, SOLIDOSV
	JE CC
 
CMP DX,0
JE QUADRADO1_COLORIDO  

CMP DX,1
JE RETANGULO1_COLORIDO 

CMP DX,2
JE RETANGULO21_COLORIDO 

CMP DX,3
JE TRIANGULO1_COLORIDO 
 
CMP DX,4
JE TRIANGULO21_COLORIDO 

QUADRADO1_COLORIDO : mov ah,0ch
           MOV AL,CORVV
           CALL QUADRADO 
		   CALL QUADRADO_COLORIDO 
JMP FIM_COLORIDO

RETANGULO1_COLORIDO :mov ah,0ch
  MOV AL,CORVV
 CALL RETANGULO
 call RETANGULO_COLORIDO
JMP FIM_COLORIDO

RETANGULO21_COLORIDO :mov ah,0ch
           MOV AL,CORVV
 CALL RETANGULO2
 CALL RETANGULO2_COLORIDO
JMP FIM_COLORIDO

TRIANGULO1_COLORIDO :mov ah,0ch
           MOV AL,CORVV
  CALL TRIANGULO
   CALL TRIANGULO_COLORIDO
JMP FIM_COLORIDO

TRIANGULO21_COLORIDO :mov ah,0ch
           MOV AL,CORVV
 CALL TRIANGULO2
 CALL TRIANGULO2_COLORIDO
JMP FIM_COLORIDO
MOV DX,0
FIM_COLORIDO: RET
SOLIDOS_COLORIDOS ENDP
;-----------------------------------------------
QUADRADO_COLORIDO PROC
MOV CX,X  ;horizontal -- eixo x T
MOV DX,Y  ;vertical   -- eixo yT
	 
 QC: int 10h
inc dx
cmp dx,Y_FINAL
jne QC
mov dx,Y
inc cx
cmp cx,X_FINAL
jne QC
RET
QUADRADO_COLORIDO ENDP 
;----------------------------------------------
 RETANGULO2_COLORIDO PROC
   
    MOV CX,X  ;horizontal -- eixo x T
	MOV DX,Y  ;vertical   -- eixo yT
	 
  QC1: int 10h
inc dx
cmp dx,Y_FINAL
jne QC1
mov dx,Y
inc cx
cmp cx,X_FINAL
jne QC1
 
 RET
 RETANGULO2_COLORIDO ENDP
;-------------------------------------------------
  RETANGULO_COLORIDO PROC
   
    MOV CX,X  ;horizontal -- eixo x T
	MOV DX,Y  ;vertical   -- eixo yT
	 
  QC2: int 10h
inc dx
cmp dx,Y_FINAL
jne QC2
mov dx,Y
inc cx
cmp cx,X_FINAL
jne QC2
 
 RET
 RETANGULO_COLORIDO ENDP
;-----------------------------------------------
TRIANGULO2_COLORIDO PROC
 MOV CX,X  ;horizontal -- eixo x T
	MOV DX,Y  ;vertical   -- eixo yT
	 
   TC1: int 10h
inc dx
cmp dx,Y_FINAL
jne TC1
DEC Y_FINAL
mov dx,Y
inc cx
cmp cx,X_FINAL
jne TC1
	 RET
	 
TRIANGULO2_COLORIDO ENDP
;---------------------------------------
TRIANGULO_COLORIDO PROC
 MOV CX,X_FINAL  ;horizontal -- eixo x T
	MOV DX,Y_FINAL  ;vertical   -- eixo yT
	 
TC11: int 10h
DEC dx
cmp dx,Y
jne TC11
INC Y
mov dx,Y_FINAL
DEC cx
cmp cx,X
jne TC11
	 RET
	 
TRIANGULO_COLORIDO ENDP
;-----------------------------------------------------------
COR_DEFINIDA PROC

CMP CORE,0
JE COR1P
CMP CORE,1
JE COR2P
CMP CORE,2
JE COR3P
CMP CORE,3
JE COR4P
CMP CORE,4
JE COR5P

 
  COR1P:  mov ah,0ch   ;print pixel por pixel 
	     mov al,0001b ;escolhendo a  cor - azul
		 MOV CORVV,AL
		 JMP FIM2
		 
  COR2P:  mov ah,0ch   ;print pixel por pixel 
	     mov al,0010b ;escolhendo a  cor - verde
	
		 MOV CORVV,AL
		 JMP FIM2
		 
 COR3P:  mov ah,0ch   ;print pixel por pixel 
	    mov al,0100b ;escolhendo a  cor VERMELHO
		MOV CORVV,AL
		JMP FIM2
		
				 
 COR4P:  mov ah,0ch   ;print pixel por pixel 
	    mov al,0101b ;escolhendo a  cor rosa
		 MOV CORVV,AL
		JMP FIM2
		
COR5P:   mov ah,0ch   ;print pixel por pixel 
	    mov al,0011b ;escolhendo a  cor -
		MOV CORVV,AL
		JMP FIM2
		
	FIM2:RET 	 
COR_DEFINIDA ENDP
;-----------------------------------------------------------
SOLIDOS_COLORIDOS_DEFINIDA PROC

CMP SOLI,0
JE QUADRADO1_COLORIDOP  

CMP SOLI,1
JE RETANGULO1_COLORIDOP 

CMP SOLI,2
JE RETANGULO21_COLORIDOP 

CMP SOLI,3
JE TRIANGULO1_COLORIDOP 
 
CMP SOLI,4
JE TRIANGULO21_COLORIDOP 
 
QUADRADO1_COLORIDOP : mov ah,0ch
           MOV AL,CORVV
           CALL QUADRADO 
		   CALL QUADRADO_COLORIDO 
JMP FIM_COLORIDOP
RETANGULO1_COLORIDOP :mov ah,0ch
 MOV AL,CORVV
 CALL RETANGULO
 call RETANGULO_COLORIDO
 
JMP FIM_COLORIDOP
RETANGULO21_COLORIDOP :mov ah,0ch
           MOV AL,CORVV
 CALL RETANGULO2
 CALL RETANGULO2_COLORIDO
JMP FIM_COLORIDOP
TRIANGULO1_COLORIDOP :mov ah,0ch
           MOV AL,CORVV
  CALL TRIANGULO
   CALL TRIANGULO_COLORIDO
JMP FIM_COLORIDOP
TRIANGULO21_COLORIDOP :mov ah,0ch
           MOV AL,CORVV
 CALL TRIANGULO2
 CALL TRIANGULO2_COLORIDO
JMP FIM_COLORIDOP
MOV DX,0
FIM_COLORIDOP: RET
SOLIDOS_COLORIDOS_DEFINIDA ENDP
;---------------------------------------------------------
TELA_ACERTOU PROC

     mov al, 13h ; seta modo de video
	  mov ah, 0
	 int 10h
		

		MOV AH,2H    ; PULAR LINHA 
		MOV DL,0DH
		INT 21H
		MOV DL,0AH
		INT 21H
		
		LEA DX,ACERTOU  ;PRIMEIRA FRASE
		MOV     AH,9H
		INT 	21H
		
		
RET
TELA_ACERTOU ENDP
;---------------------------------------------------------------------------------------
TELA_ERROU PROC

	 mov al, 13h ; seta modo de video
	 mov ah, 0
	 int 10h
		
		MOV AH,2H    ; PULAR LINHA 
		MOV DL,0DH
		INT 21H
		MOV DL,0AH
		INT 21H
		
		
		LEA DX,ERROU ;PRIMEIRA FRASE
		MOV     AH,9H
		INT 	21H

		
		
RET
TELA_ERROU ENDP
;--------------------------------------------------------------
PARTE_SUPERIOR_DEFINIDA PROC

mov al, 13h ; seta modo de video
	 mov ah, 0
	 int 10h

CMP COR_1,0
JE COR1P_1
CMP COR_1,1
JE COR2P_1
CMP COR_1,2
JE COR3P_1
CMP COR_1,3
JE COR4P_1
CMP COR_1,4
JE COR5P_1

 
  COR1P_1:  mov ah,0ch   ;print pixel por pixel 
	     mov al,0001b ;escolhendo a  cor - azul
		 MOV CORVV, AL
		 JMP FIM2_1
		 
  COR2P_1:  mov ah,0ch   ;print pixel por pixel 
	     mov al,0010b ;escolhendo a  cor - verde
	
		 MOV CORVV, AL
		 JMP FIM2_1
		 
 COR3P_1:  mov ah,0ch   ;print pixel por pixel 
	    mov al,0100b ;escolhendo a  cor VERMELHO
		MOV CORVV, AL
		JMP FIM2_1
		
				 
 COR4P_1:  mov ah,0ch   ;print pixel por pixel 
	    mov al,0101b ;escolhendo a  cor rosa
		 MOV CORVV, AL
		JMP FIM2_1
		
COR5P_1:   mov ah,0ch   ;print pixel por pixel 
	    mov al,0011b ;escolhendo a  cor -
		MOV CORVV, AL
		JMP FIM2_1
		



FIM2_1:MOV X,65   
	 MOV X_FINAL,125
	 MOV Y,5  
	 MOV Y_FINAL,65


CMP SOLIDOS_1,0
JE  SOLIDOS_1_QUADRADO
CMP SOLIDOS_1,1
JE  SOLIDOS_1_RETANGULO
CMP SOLIDOS_1,2
JE  SOLIDOS_1_RETANGULO2
CMP SOLIDOS_1,3
JE  SOLIDOS_1_TRIANGULO
CMP SOLIDOS_1,4
JE  SOLIDOS_1_TRIANGULO2

SOLIDOS_1_QUADRADO:
mov ah,0ch
MOV AL,CORVV
CALL QUADRADO
JMP SOLIDOS_1_CONT
SOLIDOS_1_RETANGULO:
mov ah,0ch
MOV AL,CORVV
CALL RETANGULO
JMP SOLIDOS_1_CONT
SOLIDOS_1_RETANGULO2:mov ah,0ch
MOV AL,CORVV
 CALL RETANGULO2
JMP SOLIDOS_1_CONT
SOLIDOS_1_TRIANGULO:mov ah,0ch
MOV AL,CORVV
 call TRIANGULO
JMP SOLIDOS_1_CONT
SOLIDOS_1_TRIANGULO2:mov ah,0ch
MOV AL,CORVV
 CALL TRIANGULO2
JMP SOLIDOS_1_CONT


SOLIDOS_1_CONT:

CALL DIV_TELA

;figura 2
CMP COR_2,0
JE COR1P_2
CMP COR_2,1
JE COR2P_2
CMP COR_2,2
JE COR3P_2
CMP COR_2,3
JE COR4P_2
CMP COR_2,4
JE COR5P_2

 
  COR1P_2:  mov ah,0ch   ;print pixel por pixel 
	     mov al,0001b ;escolhendo a  cor - azul
		 MOV CORVV, AL
		 JMP FIM2_2
		 
  COR2P_2:  mov ah,0ch   ;print pixel por pixel 
	     mov al,0010b ;escolhendo a  cor - verde
	
		 MOV CORVV, AL
		 JMP FIM2_2
		 
 COR3P_2:  mov ah,0ch   ;print pixel por pixel 
	    mov al,0100b ;escolhendo a  cor VERMELHO
		MOV CORVV, AL
		JMP FIM2_2
		
				 
 COR4P_2:  mov ah,0ch   ;print pixel por pixel 
	    mov al,0101b ;escolhendo a  cor rosa
		 MOV CORVV, AL
		JMP FIM2_2
		
COR5P_2:   mov ah,0ch   ;print pixel por pixel 
	    mov al,0011b ;escolhendo a  cor -
		MOV CORVV, AL
		JMP FIM2_2
		



FIM2_2:MOV X,185   
	 MOV X_FINAL,245
	 MOV Y,5  
	 MOV Y_FINAL,65


CMP SOLIDOS_2,0
JE  SOLIDOS_2_QUADRADO
CMP SOLIDOS_2,1
JE  SOLIDOS_2_RETANGULO
CMP SOLIDOS_2,2
JE  SOLIDOS_2_RETANGULO2
CMP SOLIDOS_2,3
JE  SOLIDOS_2_TRIANGULO
CMP SOLIDOS_2,4
JE  SOLIDOS_2_TRIANGULO2

SOLIDOS_2_QUADRADO:
mov ah,0ch
MOV AL,CORVV
CALL QUADRADO
JMP SOLIDOS_2_CONT
SOLIDOS_2_RETANGULO:
mov ah,0ch
MOV AL,CORVV
CALL RETANGULO
JMP SOLIDOS_2_CONT
SOLIDOS_2_RETANGULO2:mov ah,0ch
MOV AL,CORVV
 CALL RETANGULO2
JMP SOLIDOS_2_CONT
SOLIDOS_2_TRIANGULO:mov ah,0ch
MOV AL,CORVV
 call TRIANGULO
JMP SOLIDOS_2_CONT
SOLIDOS_2_TRIANGULO2:mov ah,0ch
MOV AL,CORVV
 CALL TRIANGULO2
JMP SOLIDOS_2_CONT


SOLIDOS_2_CONT:

RET
PARTE_SUPERIOR_DEFINIDA ENDP

;--------------------------------------------------------------
TELA_PERDEU PROC
 
    mov al, 13h ; seta modo de video
	mov ah, 0
	int 10h
	
		MOV AH,2H    ; PULAR LINHA 
		MOV DL,0DH
		INT 21H
		MOV DL,0AH
		INT 21H
	
	LEA DX,PERDEU  ;PRIMEIRA FRASE
		MOV     AH,9H
		INT 	21H
			MOV AH,2H    ; PULAR LINHA 
		MOV DL,0DH
		INT 21H
		MOV DL,0AH
		INT 21H
			MOV AH,2H    ; PULAR LINHA 
		MOV DL,0DH
		INT 21H
		MOV DL,0AH
		INT 21H
		
	VOLT_FIM_DNV1:	
	LEA DX,opcao_final  
		MOV     AH,9H
		INT 	21H
		
		MOV AH,1H
		INT 21H
	
	
		CMP al,'s'
		JE DENOVOO
		
		CMP al,'n'
		JE FIMJ
		
		JMP VOLT_FIM_DNV1
		
DENOVOO: CALL AGAIN 
JMP TELA_PERDEU_FIM
FIMJ: CALL PLACAR
JMP TELA_PERDEU_FIM
	TELA_PERDEU_FIM:
RET
TELA_PERDEU ENDP
;----------------------------------------------------------
TELA_GANHOU PROC

    mov al, 13h ; seta modo de video
	mov ah, 0
	int 10h
	
		MOV AH,2H    ; PULAR LINHA 
		MOV DL,0DH
		INT 21H
		MOV DL,0AH
		INT 21H
	
	   LEA DX,GANHOU  
	  	MOV     AH,9H
		INT 	21H
		
			MOV AH,2H    ; PULAR LINHA 
		MOV DL,0DH
		INT 21H
		MOV DL,0AH
		INT 21H
		MOV AH,2H    ; PULAR LINHA 
		MOV DL,0DH
		INT 21H
		MOV DL,0AH
		INT 21H
	VOLT_FIM_DNV:	
		LEA DX,opcao_final  
		MOV     AH,9H
		INT 	21H
		
		MOV AH,1H
		INT 21H
		
		
		CMP al,'s'
		JE DENOVO
		
		CMP al,'n'
		JE FIMJOGO
		
		JMP VOLT_FIM_DNV
		
DENOVO: CALL AGAIN 
        JMP TELA_GANHOU_FIM
FIMJOGO: CALL PLACAR
	JMP TELA_GANHOU_FIM
	
	TELA_GANHOU_FIM:
RET
TELA_GANHOU ENDP
;-------------------------------------------------------------------------
AGAIN PROC
MOV CONT, 0
CALL MAIN
RET

AGAIN ENDP
;-------------------------------------------------------------------------
PLACAR PROC
mov al, 13h ; seta modo de video
	mov ah, 0
	int 10h

	
		MOV AH,2H    ; PULAR LINHA 
		MOV DL,0DH
		INT 21H
		MOV DL,0AH
		INT 21H
		LEA 	DX,SCORE1   
		MOV     AH,9H
		INT 	21H
	
	    LEA 	DX,SCORE 
		MOV     AH,9H
		INT 	21H
		
		LEA 	DX,SCORE2  
		MOV     AH,9H
		INT 	21H
		
		MOV AH,2H    ; PULAR LINHA 
		MOV DL,0DH
		INT 21H
		MOV DL,0AH
		INT 21H
		
		MOV AH,2H    ; PULAR LINHA 
		MOV DL,0DH
		INT 21H
		MOV DL,0AH
		INT 21H
		
		MOV AH,2H    ; PULAR LINHA 
		MOV DL,0DH
		INT 21H
		MOV DL,0AH
		INT 21H
		
		    LEA 	DX,print_erros
		MOV     AH,9H
		INT 	21H
		
		MOV CX,ERRO
	
		CALL SAI_NUM
  

  MOV AH,2H    ; PULAR LINHA 
		MOV DL,0DH
		INT 21H
		MOV DL,0AH
		INT 21H
   
       LEA 	DX,print_acertos
		MOV     AH,9H
		INT 	21H
		
		
			MOV CX,ACERTO
		
		CALL SAI_NUM
	
	MOV AH,2H    ; PULAR LINHA 
		MOV DL,0DH
		INT 21H
		MOV DL,0AH
		INT 21H
		
	
	
	
LEA 	DX,INICIO2   ;TERCEIRA FRASE
		MOV     AH,9H
		INT 	21H
		
		mov ah,1 ;CONTINUAR... 
     int 21h
	 
     mov al, 13h ; seta modo de video
	mov ah, 0
	int 10h
	
      MOV X,185   
	 MOV X_FINAL,245
	 MOV Y,5  
	 MOV Y_FINAL,65
		 mov ah,0ch   ;print pixel por pixel 
	     mov al,0001b ;escolhendo a  cor - azul
		call triangulo
		 
 MOV X,10   
	 MOV X_FINAL, 70
	 MOV Y,120  
	 MOV Y_FINAL,180
		 mov ah,0ch   ;print pixel por pixel 
	     mov al,0010b ;escolhendo a  cor - verde
		call retangulo
		 
 MOV X,155   
	 MOV X_FINAL,215
	 MOV Y,120  
	 MOV Y_FINAL,180
		mov ah,0ch   ;print pixel por pixel 
	    mov al,0100b ;escolhendo a  cor VERMELHO
		call quadrado
		
 MOV X, 225   
	 MOV X_FINAL,285
	 MOV Y,120  
	 MOV Y_FINAL,180
		mov ah,0ch   ;print pixel por pixel 
	    mov al,0101b ;escolhendo a  cor rosa
	call triangulo2
		
 MOV X,85   
	 MOV X_FINAL,145
	 MOV Y,120  
	 MOV Y_FINAL,180
		mov ah,0ch   ;print pixel por pixel 
	    mov al,0011b ;escolhendo a  cor -
		call retangulo2





MOV AH,4CH
INT 21H
RET
PLACAR ENDP
;-------------------------------------------------------------------------



;******************************************

SAI_NUM PROC


		
		
		MOV 	AX,CX
		
		PUSH 	AX
		PUSH 	BX
		PUSH 	CX
		PUSH 	DX 		;salva na pilha os registradores usados
		OR 		AX,AX 	;prepara comparação de sinal
		JGE 	PT1 	;se AX maior ou igual a 0, vai para PT1
		PUSH 	AX 		;como AX menor que 0, salva o número na pilha
		MOV 	DL,'-'	;prepara o caracter ' - ' para sair
		MOV 	AH,2h 	;prepara exibição
		INT 	21h 	;exibe ' - '
		POP 	AX 		;recupera o número
		NEG 	AX 		;troca o sinal de AX (AX = - AX)
		
		;obtendo dígitos decimais e salvando-os temporariamente na pilha
PT1: 	XOR 	CX,CX 	;inicializa CX como contador de dígitos
		MOV 	BX,10 	;BX possui o divisor
PT2: 	XOR 	DX,DX 	;inicializa o byte alto do dividendo em 0; restante é AX
		DIV 	BX 		;após a execução, AX = quociente; DX = resto
		PUSH 	DX 		;salva o primeiro dígito decimal na pilha (1o. resto)
		INC 	CX 		;contador = contador + 1
		OR 		AX,AX 	;quociente = 0 ? (teste de parada)
		JNE 	PT2 	;não, continuamos a repetir o laço
		
		;exibindo os dígitos decimais (restos) no monitor, na ordem inversa
		MOV 	AH,2h 	;sim, termina o processo, prepara exibição dos restos
PT3: 	POP 	DX 		;recupera dígito da pilha colocando-o em DL (DH = 0)
		ADD 	DL,30h 	;converte valor binário do dígito para caracter ASCII
		INT 	21h 	;exibe caracter
		LOOP 	PT3 	;realiza o loop ate que CX = 0
		POP 	DX 		;restaura o conteúdo dos registros
		POP 	CX
		POP 	BX
		POP 	AX 		;restaura os conteúdos dos registradores
		RET 			;retorna à rotina que chamou
		
SAI_NUM ENDP
;---------------------------------------------------------------------
PINTAR_SOLIDO1 PROC
CMP COR_1,0
JE COR1P_11
CMP COR_1,1
JE COR2P_11
CMP COR_1,2
JE COR3P_11
CMP COR_1,3
JE COR4P_11
CMP COR_1,4
JE COR5P_11

 
  COR1P_11:  mov ah,0ch   ;print pixel por pixel 
	     mov al,0001b ;escolhendo a  cor - azul
		 MOV CORVV, AL
		 JMP FIM2_11
		 
  COR2P_11:  mov ah,0ch   ;print pixel por pixel 
	     mov al,0010b ;escolhendo a  cor - verde
	
		 MOV CORVV, AL
		 JMP FIM2_11
		 
 COR3P_11:  mov ah,0ch   ;print pixel por pixel 
	    mov al,0100b ;escolhendo a  cor VERMELHO
		MOV CORVV, AL
		JMP FIM2_11
		
				 
 COR4P_11:  mov ah,0ch   ;print pixel por pixel 
	    mov al,0101b ;escolhendo a  cor rosa
		 MOV CORVV, AL
		JMP FIM2_11
		
COR5P_11:   mov ah,0ch   ;print pixel por pixel 
	    mov al,0011b ;escolhendo a  cor -
		MOV CORVV, AL
		JMP FIM2_11
		



FIM2_11:MOV X,65   
	 MOV X_FINAL,125
	 MOV Y,5  
	 MOV Y_FINAL,65


CMP SOLIDOS_1,0
JE  SOLIDOS_1_QUADRADO1
CMP SOLIDOS_1,1
JE  SOLIDOS_1_RETANGULO1
CMP SOLIDOS_1,2
JE  SOLIDOS_1_RETANGULO21
CMP SOLIDOS_1,3
JE  SOLIDOS_1_TRIANGULO1
CMP SOLIDOS_1,4
JE  SOLIDOS_1_TRIANGULO21

SOLIDOS_1_QUADRADO1:
mov ah,0ch
MOV AL,CORVV
CALL QUADRADO_COLORIDO
JMP SOLIDOS_1_CONT1

SOLIDOS_1_RETANGULO1:
mov ah,0ch
MOV AL,CORVV
CALL RETANGULO_COLORIDO
JMP SOLIDOS_1_CONT1

SOLIDOS_1_RETANGULO21:mov ah,0ch
MOV AL,CORVV
 CALL RETANGULO2_COLORIDO
JMP SOLIDOS_1_CONT1

SOLIDOS_1_TRIANGULO1:mov ah,0ch
MOV AL,CORVV
 call TRIANGULO_COLORIDO
JMP SOLIDOS_1_CONT1

SOLIDOS_1_TRIANGULO21:mov ah,0ch
MOV AL,CORVV
 CALL TRIANGULO2_COLORIDO
JMP SOLIDOS_1_CONT1


SOLIDOS_1_CONT1:



RET
PINTAR_SOLIDO1 ENDP

end main