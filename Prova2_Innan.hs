-- Innan Plínio Rangel Amorim 16.2.8416
-- Resolucao Segunda Prova Linguagens de Programacao


--1. Defina as funcoes a seguir utilizando apenas foldr, foldl, map e filter.
--(a) allOdd :: [Int] -> [Int], que cria um lista contendo somente os valores impares da lista
--de entrada.
--allOdd [1,2,4,6,2,1,5,6,8,9] = [1,1,5,9]

allOdd :: [Int] -> [Int]
allOdd = filter odd


--(b) strip :: Eq a => [a] -> [a] -> [a] que elimina do segundo argumento, todos os elementos do
--primeiro argumento.
--strip "ask" "Haskell" = "Hell"
strip :: Eq a => [a] -> [a] -> [a]
strip xs ys = filter (\y -> not(y `elem` xs)) ys 


--(c) concatL :: [[a]] -> [a] que concatena todas as listas uma lista.
--concatL ["um ", "dois ", "tres"] = "um dois tres"
concatL :: [[a]] -> [a]
concatL a = foldr (++) [](a)

--(d) tamanho :: [a] -> Int que retorna o tamanho da lista
--tamanho :: [a] -> Int
tamanho1 :: [a] -> Int
tamanho1 xs = foldr (\_ r -> r+1) 0 xs

--2. Utilizando compreens~ao de lista, defina as funcoes:
--(a) conta :: Eq a -> a -> [a] -> Int que retorna a quantidade de vezes que o primeiro argumento
--acontece no segundo argumento
--conta 1 [1, 2, 3, 4, 1, 1, 2, 3, 5, 5, 1, 2, 3, 2] = 4
conta :: Eq a => a -> [a] -> Int
conta b c = length[ b | d<-c, d==b]


--(b) ordenado :: Ord a => [a] -> Bool que dado uma lista, retorna verdadeiro se a lista esta ordenada.
--ordenado [1, 2, 5, 7] = True
--ordenado [3, 3, 55, 7] = False
ordenado :: Ord a => [a] -> Bool
ordenado [] = True
ordenado (x:xs) = (and [ x<= i| i<-xs ]) && ordenado xs


--(c) tamanho :: [a] -> Int que retorna o tamanho da lista
--tamanho [1, 2, 3] = 3
tamanho :: [a] -> Int
tamanho a = sum[ 1 | _<-a]


--3. Seja uma arvore binaria de busca representada da seguinte maneira:
data Tree a = Leaf | Node (Tree a) a (Tree a) deriving (Show)

--Crie as funcoes que facam:
--(a) Adicione um elemento a arvore
addTree :: (Ord a) => Tree a -> a -> Tree a
addTree Leaf x = Node Leaf x Leaf
addTree (Node e r d) x
  | x > r = Node e r (addTree d x)
  | otherwise = Node (addTree e x) r d


--(b) Compute o tamanho da arvore
alturaTree :: Tree a -> Int
alturaTree Leaf = 0
alturaTree (Node e n d) = 1 + max ae ad
  where
  ae = alturaTree e
  ad = alturaTree d

--(c) Aplica uma funcao em todos os elementos de uma arvore
mapT :: (a -> b) -> Tree a -> Tree b
mapT f Leaf = Leaf
mapT f (Node e r d) = Node (mapT f e) (f r) (mapT f d) 
