-- Innan Plínio Rangel Amorim 16.2.8416
-- Segundo Trabalho Prático
-- Para a disciplina Linguagens de Programação
import Control.Monad (sequence)
data Formula = Lit Bool
  | Var String
  | E Formula Formula
  | Ou Formula Formula
  | Nao Formula
  deriving (Show, Eq)
  
--1.2 Contexto
--Para conseguir avaliar uma formula da logica, e necessario um contexto, que e um lista que contem o
--nome da variavel e o valor da mesma (Verdadeiro ou Falso).
type Contexto = [(String, Bool)]


--1.3 Tabela Verdade
--E necessario, tambem, o tipo dados para a Tabela Verdade que sao todos os contexto e seus respectivos
--resultados para uma dada formula.
type TabelaVerdade = [(Contexto, Bool)]


--Variáveis para teste das funções
x1 = [("a",True),("b",False), ("c", True)]
x2 = (Var "c")
x3 = (Ou (Ou (Var "a") (Var "b")) (Var "c"))



--2 Implementacao
--2.1 Avaliar uma formula
--Defina a funcao avaliar que dado uma formula e um contexto, diz qual e o resultado da formula dado
--esse contexto.
avalia :: Contexto -> Formula -> Bool
avalia context (Lit bool) = bool
avalia context (Var string) = returnBool context string
avalia context (E x1 x2) = avalia context x1 && avalia context x2
avalia context (Ou x1 x2) = avalia context x1 || avalia context x2
avalia context (Nao x1) = not (avalia context x1)

returnBool :: Contexto -> String -> Bool
returnBool ((str,bool):tail) string 
    |str == string = bool
    |otherwise = returnBool tail string


--2.2 Tabela Verdade
--Defina a funcao que resolva para todos os casos de um formula, ou seja, faca a tabela verdade de uma
--formula.

--Função que recupera todas variáveis da fórmula
recVar :: Formula -> [String]
recVar (Lit s) = []
recVar (Var s) = [s]
recVar (Nao x1) = recVar x1
recVar (E x1 x2) = (recVar x1) ++ (recVar x2)
recVar (Ou x1 x2) = (recVar x1) ++ (recVar x2)

--Função que retira variáveis repetidas
repetidos :: [String] -> [String]
repetidos [] = []
repetidos (x:xs) = x:(repetidos (filter (/=x) xs))

--Função que cria todas possibilidades da tabela verdade
geraTabela :: Int -> [[Bool]]
geraTabela n = sequence (replicate n [True,False])

--Converte todas as possibilidades em contexto
contextVec :: [String] -> [[Bool]] -> [Contexto]
contextVec s [] = []
contextVec s (x:xs) = [zip s x] ++ (contextVec s xs)

--Aplica todas as fórmulas a todos contextos no vetor de contextos
avaliaContextos :: Formula -> [Contexto] -> TabelaVerdade
avaliaContextos f [] = []
avaliaContextos f (x:xs) = [(x, (avalia x f))] ++ (avaliaContextos f xs)

--Efetua toda tabela verdade
truthTable :: Formula -> TabelaVerdade
truthTable f = rst
  where
  str = repetidos (recVar f)
  all = geraTabela (length str)
  ctx = contextVec str all
  rst = avaliaContextos f ctx




--2.3 Tautologia e Contradicao
--Defina as funcoes de tautologia e contradicao para uma formula.

--retorna um vetor de booleano com as saídas da table verdade
vecRespostas :: TabelaVerdade -> [Bool]
vecRespostas [] = []
vecRespostas ((cont,bol):xs) = [bol] ++ (vecRespostas xs)

--tautologia
tautologia :: Formula -> Bool
tautologia f
  | and vec == True = True
  | otherwise = False
  where
  vec = vecRespostas (truthTable f)


--contradicao
contradicao :: Formula -> Bool
contradicao f
  | or vec == False = True
  | otherwise = False
  where
  vec = vecRespostas (truthTable f)


















































