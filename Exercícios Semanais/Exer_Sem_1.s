.text
.global CheckABS
.type CheckABS, "function"
CheckABS: MOV W6, 0
CICLO:	  CBZ X1, FIM
		  LDR W5, [X2]
		  CMP W5, 0
		  B.GT CICLO1
		  NEG W5, W5
CICLO1:   CMP W5, W0
		  B.LE CICLO3
		  MOV W5, 0
		  STR W5, [X2]
		  ADD W6, W6, 1
CICLO3:   ADD X2, X2, #4
		  SUB X1, X1, 1
		  B CICLO
FIM:	  MOV W0, W6
ret
