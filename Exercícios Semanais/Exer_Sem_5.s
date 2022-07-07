.text
.global histo
.type histo, "function"

histo:				MOV X6, X0 // Preservar o número de notas
					MOV X7, #0 // Média
					MOV X8, X1 // Preservar o endereço base da sequência de notas
					MOV X11, X2
					MOV X10, #16
					UDIV X6, X6, X10 // Número de vezes a percorrer CICLO

CICLO:				CBZ X6, CICLO2
					LDR Q3, [X1], #16
					ADDV B3, V3.16B // Somar as 16 notas
					SMOV X4, V3.S[0] // Vai buscar o S3 e coloca em X3
					ADD X7, X7, X4
					SUB X6, X6, #1
					B CICLO

CICLO2:				UDIV X6, X0, X10
					//MOV X8, X1 // Resetar o enderço base da sequência de notas
					UCVTF S7, X7 // Converter para float
					UCVTF S0, X0
					FDIV S7, S7, S0 // Média

CICLO4:				MOV X2, X11
					MOV X7, #0
					MOV X9, #20
					LDR Q0, [X8], #16
					CBZ X6, FIM
					SUB X6, X6, #1
CICLO3:				CMP X9, #-1
					B.EQ CICLO4
					DUP V9.16B, W7 // Replicar a nota de 0 a 20 no vetor V9
					CMEQ V9.16B, V0.16B, V9.16B
					ADDV B9, V9.16B
					SMOV X3, V9.B[0]
					NEG X3, X3
					LDRB W4, [X2]
					ADD W3, W3, W4
					STRB W3, [X2], #1
					SUB X9, X9, #1
					ADD X7, X7, #1
					B CICLO3



FIM:				FMOV S0, S7
RET
