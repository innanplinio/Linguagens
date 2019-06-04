%
% Primeiro Trabalho de Linguagens - PROLOG
% Innan Plínio - 16.2.8416
% Bruno Passamai - 13.2.8458
%


%
%
% Exemplo de uso do programa: start([[1,1],[1,1]],0,0).
% Irá gerar como saida um arquivo de texto 
% que ficará salvo em C:\\solutions.txt
% Caminho de saida pode ser alterado na linha #103
% Executar programa como ADMINISTRADOR.
% 
%

%
% Predicado para iniciar o programa.
%
start(M1, X, Y):- (write('Iniciado!'), moveMatrix(M1, X, Y), fail); nl, write('Finalizado!'), nl, write('Arquivo de saida encontra-se em: C:\\\\solutions.txt').

%
% Predicado para percorrer a matriz até não conseguir andar mais.
%
moveMatrix(M1, X, Y):- tryMove(M1, X, Y, M2, Xnew, Ynew,Aux),  moveMatrix(M2, Xnew, Ynew), writeFile(Aux) ; verifyMatrix(M1,X,Y),writeFile('\n').

%
%
% Predicado para dado uma posição na matriz, retorna elemento
% se o mesmo existir, se não, retorna falso.
%
%
elemnt(R,[X|_],0,PosY):- element_at(R,X,PosY).
elemnt(R,[_|XS],PosX,PosY):- PX is PosX -1, elemnt(R,XS,PX,PosY).
element_at(X,[X|_],0).
element_at(X,[_|L],K) :- K > 0, K1 is K - 1, element_at(X,L,K1).


%
%
% Predicado para verificar se a matriz é toda negativa,
% Exceto posição atual, que deve ser igual a zero.
%
%
verifyMatrix(M1, X, Y):- elemnt(R, M1, X, Y), R==0, replaceMatrix(M1, X, Y, -1, M2), verify(M2).
verify([]).
verify([M|Ms]) :- verifyPlus(M),verify(Ms).
verifyPlus([]).
verifyPlus([M|Ms]):- test(M,-1),verifyPlus(Ms).
test(X,X).


%
%
% Predicado para tentar se mover pela matriz seguindo a ordem
% Direita->Baixo->Esquerda->Cima
%
%
tryMove(M1, X, Y, M2, Xnew, Ynew, Aux):- (moveRight(M1, X, Y, Xnew, Ynew, M2),Aux = "R "); (moveDown(M1, X, Y, Xnew, Ynew, M2),Aux = "D "); (moveLeft(M1, X, Y, Xnew, Ynew, M2),Aux = "L "); (moveUp(M1, X, Y, Xnew, Ynew, M2),Aux = "U ").


%
%
% predicado para susbtituir elemento dentro da MATRIZ dado INDEX
%
%
replaceMatrix(M1, Px, Py, X, M2):-element_at(R, M1, Px),replace(R, Py, X, Rnew), replace(M1,Px,Rnew,M2).

%
%
% Predicado para substituir elemento dentro da LISTA dado INDEX
%
%

replace([_|T], 0, X, [X|T]).
replace([H|T], I, X, [H|R]):- I > -1, NI is I-1, replace(T, NI, X, R), !.

%
%
% Predicados para se movimentar na matriz, verificando se o próximo
% elemento existe, e se o elemento tem valor maior ou igual a zero.
% Caso o movimento seja possivel, diminui o valor do elemento na
% posição atual, e passa o INDEX da proxima posição.
%
%

moveRight(M1, Px, Py, Px, Pynew, M2):-Aux is Py+1, elemnt(R,M1,Px,Aux), R>=0, elemnt(R2, M1, Px, Py), Rnew is R2-1,replaceMatrix(M1, Px, Py, Rnew, M2), Pynew is Py+1.

moveDown(M1, Px, Py, Pxnew, Py, M2):- Aux is Px+1, elemnt(R,M1,Aux,Py), R>=0, elemnt(R2, M1, Px, Py), Rnew is R2-1, replaceMatrix(M1, Px, Py, Rnew, M2), Pxnew is Px+1.

moveLeft(M1, Px, Py, Px, Pynew, M2):- Aux is Py-1, elemnt(R,M1,Px,Aux), R>=0, elemnt(R2, M1, Px, Py), Rnew is R2-1, replaceMatrix(M1, Px, Py, Rnew, M2), Pynew is Py-1.

moveUp(M1, Px, Py, Pxnew, Py, M2):- Aux is Px-1, elemnt(R,M1,Aux,Py), R>=0, elemnt(R2, M1, Px, Py), Rnew is R2-1, replaceMatrix(M1, Px, Py, Rnew, M2), Pxnew is Px-1.


%
%
% Escreve no
% arquivo de saida.
%
%
writeFile(X):- open('C:\\solutions.txt',append,Stream),
         write(Stream,X),
         close(Stream).

