{-# OPTIONS_GHC -Wall #-}
{--
    LCPF : Projet
    Les enfants bouées
    by Quentin Carpentier & Paul-Joseph Krogulec.
-}

module Problem1 where
import EL

{- Fonction qui prend une proposition enargument 
et renvoie la liste de mondes possibles où la proposition est vraie. -}
interp :: Prop -> [World]
interp "as" = [10 ,11]
interp "bs" = [01 ,11]
interp _    = []

{- Fonction qui prend un agent i et un monde possible w en arguments,
et renvoie la liste de mondes possibles qui sont indiscernables du monde w pour l'agent i. -}
indis :: Agent -> World -> [World]
indis "a" 00 = [00 ,10]
indis "b" 00 = [00 ,01]

{- Définition complète de l'état épistémique initial du problème. -}
s0 :: EpiState
s0 = (interp, indis, 01)

{- Exprime l'annonce du père, c.-à-d., « Un parmi vous a le visage sale. » -}
fatherAnn :: EpiFormula
fatherAnn = Or (Var "as") (Var "bs")

{- Exprime l'ignorance d'Alice sur son état, « Alice ne sait pas que le visage d'Alice est sale, 
et Alice ne sait pas que le visage d'Alice n’est pas sale. » -}
aliceIgn :: EpiFormula
aliceIgn = Not (And (Knows "a" (Var "as")) (Knows "a" (Not (Var "as"))))

{- Exprime l'ignorance de Bob sur son état, « Bob ne sait pas que le visage de Bob est sale, 
et Bob ne sait pas que le visage de Bob n’est pas sale. » -}
bobIgn :: EpiFormula
bobIgn = Not (And (Knows "b" (Var "bs")) (Knows "b" (Not (Var "bs"))))

{- Exprime le problème 1 dans sa totalité. -}
problem1 :: EpiFormula
problem1 = After (fatherAnn) (And (aliceIgn) (After (Knows "b" (Not (Var "bs"))) (And (Not aliceIgn) (Not bobIgn))))