.text
.global closestCircle
.type closestCircle, "function"

closestCircle:		MOV X5, X2 // Conservar o n� de c�rculos da sequ�ncia de c�rculos
					MOV X6, X3 // Conservar endere�o base da sequ�ncia de c�rculos
					mov x7, x3
					MOV X10, X0 // Conservar o n� de pontos da sequ�ncia de pontos

CICLO_PONTOS:		MOV X20, #-1 // �ndice final da sequ�ncia ID
					MOV X2, X5 // Resetar o n� de c�rculos total

					CBZ X0, FIM // Verificar se j� chegou ao fim da sequ�ncia de pontos
					SUB X0, X0, #1 // Subtrair #1 ao n�mero de pontos de faltam verificar
					LDR S0, [X1] // x(abcissa) do ponto
					ADD X1, X1, #4
					LDR S1, [X1] // y(ordenada) do ponto
					ADD X1, X1, #4 // Pr�ximo ponto da sequ�ncia de pontos
					FCVT D1, S1 // Tornar um double em float
					FCVT D0, S0 // Tornar um double em float

CICLO_CIRC:			CBZ X2, CLICO2
					SUB X2, X2, #1 // Subtrair #1 ao n� de c�rculos que faltam verificar
					LDR D2, [x3] // x(abcissa) do centro do c�rculo
					ADD X3, X3, #8
					LDR D3, [X3] // y(ordenada) do centro da circunfer�ncia
					ADD X3, X3, #8
					LDR D4, [X3] // r(raio) do c�rculo
					ADD X3, X3, #8 // Endere�o do pr�ximo c�rculo

					FSUB D8, D0, D2 // (x - xc)
					FMUL D8, D8, D8 // (x - xc)^2
					FSUB D9, D1, D3 // (y - yc)
					FMUL D9, D9, D9 // (y - yc) ^2
					FADD D8, D8, D9 // (x - xc)^2 + (y - yc)^2
					FSQRT D8, D8 // sqrt( (x - xc)^2 + (y - yc)^2 )
					FSUB D8, D8, D4 // d = ( sqrt( (x - xc)^2 + (y - yc)^2 ) ) - r

					FCMP D8, #0.0
					B.LE CICLO_CIRC // Se (d <= 0), ent�o � porque  ponto pertence ao c�rculo e n�o � suposto analisar
					ADD X19, X2, #1 // Somar #1 ao n� de c�rculos a percorrer e guardar em X19
					SUB X19, X5, X19 // (NC - NCa_percorrer) -> �ndice do c�rculo a percorrer
					CBZ X19, CICLO3 // Se o c�rculo a analisar for o primeiro, saltar para CICLO3

					FCMP D8, D22 // Comparar a d(circ. atual) com o d(circ. mais pequeno)
					B.GT CICLO_CIRC // Caso d(circ. atual) > d(circ. mais pequeno), salta para CICLO_CIRC(analisa outro c�rculo)
					FMOV D22, D8 // A d(circ. atual) passa a ser a d(circ. mais pequeno)
					MOV X20, X19 // Atualizar o �ndice do d(circ. mais pequeno)
					B CICLO_CIRC


CLICO2:				STR X20, [X4] // Armazenar o d mais pequeno
					ADD X4, X4, #4 // Passar para a pr�xima posi��o da sequ�ncia ID
					mov x3, x7 // Resetar o endere�o base da sequ�ncia de c�rculos
					B CICLO_PONTOS

CICLO3:				MOV X20, X19 // Colocar em X20(�ndice do d mais baixo) o �ndice do primeiro c�rculo
					FMOV D22, D8 // Inicializar a dist�ncia mais pequena com a dist�ncia do 1� c�rculo
					B CICLO_CIRC

FIM:				RET
