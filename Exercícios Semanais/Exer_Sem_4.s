.text
.global closestCircle
.type closestCircle, "function"

closestCircle:		MOV X5, X2 // Conservar o nº de círculos da sequência de círculos
					MOV X6, X3 // Conservar endereço base da sequência de círculos
					mov x7, x3
					MOV X10, X0 // Conservar o nº de pontos da sequência de pontos

CICLO_PONTOS:		MOV X20, #-1 // Índice final da sequência ID
					MOV X2, X5 // Resetar o nº de círculos total

					CBZ X0, FIM // Verificar se já chegou ao fim da sequência de pontos
					SUB X0, X0, #1 // Subtrair #1 ao número de pontos de faltam verificar
					LDR S0, [X1] // x(abcissa) do ponto
					ADD X1, X1, #4
					LDR S1, [X1] // y(ordenada) do ponto
					ADD X1, X1, #4 // Próximo ponto da sequência de pontos
					FCVT D1, S1 // Tornar um double em float
					FCVT D0, S0 // Tornar um double em float

CICLO_CIRC:			CBZ X2, CLICO2
					SUB X2, X2, #1 // Subtrair #1 ao nº de círculos que faltam verificar
					LDR D2, [x3] // x(abcissa) do centro do círculo
					ADD X3, X3, #8
					LDR D3, [X3] // y(ordenada) do centro da circunferência
					ADD X3, X3, #8
					LDR D4, [X3] // r(raio) do círculo
					ADD X3, X3, #8 // Endereço do próximo círculo

					FSUB D8, D0, D2 // (x - xc)
					FMUL D8, D8, D8 // (x - xc)^2
					FSUB D9, D1, D3 // (y - yc)
					FMUL D9, D9, D9 // (y - yc) ^2
					FADD D8, D8, D9 // (x - xc)^2 + (y - yc)^2
					FSQRT D8, D8 // sqrt( (x - xc)^2 + (y - yc)^2 )
					FSUB D8, D8, D4 // d = ( sqrt( (x - xc)^2 + (y - yc)^2 ) ) - r

					FCMP D8, #0.0
					B.LE CICLO_CIRC // Se (d <= 0), então é porque  ponto pertence ao círculo e não é suposto analisar
					ADD X19, X2, #1 // Somar #1 ao nº de círculos a percorrer e guardar em X19
					SUB X19, X5, X19 // (NC - NCa_percorrer) -> índice do círculo a percorrer
					CBZ X19, CICLO3 // Se o círculo a analisar for o primeiro, saltar para CICLO3

					FCMP D8, D22 // Comparar a d(circ. atual) com o d(circ. mais pequeno)
					B.GT CICLO_CIRC // Caso d(circ. atual) > d(circ. mais pequeno), salta para CICLO_CIRC(analisa outro círculo)
					FMOV D22, D8 // A d(circ. atual) passa a ser a d(circ. mais pequeno)
					MOV X20, X19 // Atualizar o índice do d(circ. mais pequeno)
					B CICLO_CIRC


CLICO2:				STR X20, [X4] // Armazenar o d mais pequeno
					ADD X4, X4, #4 // Passar para a próxima posição da sequência ID
					mov x3, x7 // Resetar o endereço base da sequência de círculos
					B CICLO_PONTOS

CICLO3:				MOV X20, X19 // Colocar em X20(índice do d mais baixo) o índice do primeiro círculo
					FMOV D22, D8 // Inicializar a distância mais pequena com a distância do 1º círculo
					B CICLO_CIRC

FIM:				RET
