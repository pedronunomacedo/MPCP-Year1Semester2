.text
.global SelectedUpperCase
.type SelectedUpperCase, "function"
SelectedUpperCase: MOV X9, 0
CICLO1:			   MOV X8, X1
				   LDRB W2, [X0] // Caracter da seq_B
				   CMP W2, 0
				   B.EQ FIM
CICLO2:			   LDRB W3, [X8] // Caracter da seq_A
				   CMP W3, 0
				   B.EQ CICLO3 // Acabou de percorrer a SEQ_A?
				   CMP W2, W3
				   B.NE PROX
				   ADD X9, X9, #1 // Char_A = Char_B
				   SUB W3, W3, #32 // minuscula -> Maiuscula
				   STRB W3, [X8] // Guardar a letra Maiuscula
PROX:			   ADD X8, X8, #1 // Próximo caracter da seq_A
				   B CICLO2
CICLO3:			   ADD X0, X0, #1 // Próximo caracter da SEQ_B
				   B CICLO1
FIM:			   MOV X0, X9
				   RET
