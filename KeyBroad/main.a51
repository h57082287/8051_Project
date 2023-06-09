ORG 00H
MOV 7DH, #0FFH 	; 7-Display Status
MAIN:	
	MOV 7FH, #0FEH 	; Current Status
	MOV 7EH, #01H 	; CPL Status
	MOV 7CH, #0FFH	; Time Buffer
	MOV R1,  #00H	; Table Index
	MOV DPTR, #DIGITAL
LOOP:	
	CALL DISPLAY
	CALL KEYDECODE
	JMP MAIN
	

KEYDECODE:
	MOV R0, 7FH
	MOV P1, R0
	JNB P1.4, SET_DISPLAY
	INC R1
	CALL DELAY_250u
	JNB P1.5, SET_DISPLAY
	INC R1
	CALL DELAY_250u
	JNB P1.6, SET_DISPLAY
	INC R1
	CALL DELAY_250u
	JNB P1.7, SET_DISPLAY
	INC R1
	CALL DELAY_250u
	CALL NEXT
	CJNE R1, #10H, KEYDECODE
	RET
	
NEXT:
	MOV A, 7EH
	RL A
	MOV 7EH, A
	CPL A
	MOV 7FH, A
	RET

SET_DISPLAY:
	MOV A, R1
	MOVC A, @A+DPTR
	MOV 7DH, A
	CALL DISPLAY
	RET
	
DISPLAY:
	MOV R0, 7DH
	MOV P0, R0
	CLR P2.3
	MOV R0, 7CH
	DEC R0
	MOV 7CH, R0
	CJNE R0, #00H, DISPLAY
	RET

DELAY_250u:
	MOV R0, #0FFH
	DJNZ R0, $
	MOV R0, #0FFH
	DJNZ R0, $
	MOV R0, #0FFH
	DJNZ R0, $
	MOV R0, #0FFH
	DJNZ R0, $
	RET

DIGITAL:
	DB 0C0H
	DB 0C6H
	DB	80H
	DB  88H
	DB 0FFH
	DB  90H
	DB  82H
	DB 0B0H
	DB 0C0H
	DB  80H
	DB  92H
	DB 0A4H
	DB 0FFH
	DB 0F8H
	DB  99H
	DB 0F9H
	
		
END