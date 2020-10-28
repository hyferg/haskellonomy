{-# LANGUAGE MultiParamTypeClasses #-}

module Lib
    ( out
    ) where


import Integrator
import R1M
import R2

data Point = P (R2, R1)
data Curve = C [Point]

w :: R2 -> R2 -> TeR1
w (R2 x y) (R2 dx dy) = TeR1 (w0*dx + w1*dy)
    where
      w0 = (-y)/(1+x*y)
      w1 = 0

ts :: [Float]
tend :: Float
tend = 4
ts = [0, 0.01 .. tend]

gamma :: Float -> R2
gamma t = R2
  (cos(2*pi*t)+2)
  (sin(2*pi*t)+2)

initFiber :: R1
initFiber = R1 2

initGamma :: R2
gammas :: [R2]
(initGamma:gammas) = map gamma ts

initCond :: (R2, R1)
initCond = (initGamma, initFiber)

-- scanl lift (g0, m0) [m1, m2, ...] == [
--  (g0, m0),
--  (g0, m0) `lift` m1,
-- ((g0, m0) `lift` m1) `lift` m2, ...]
 
lifted :: [(R2, R1)]
lifted = scanl (rk w) initCond gammas

instance Show Point where
  show (P (R2 a b, R1 c)) =
    (show a) ++ " " ++ (show b) ++ " " ++ (show c) ++ "\n"
 
instance Show Curve where
   show (C nps) = concat $ map show nps

out :: String
out = show $ C $ map (P) lifted
