-- | The Index Number Problem: A Differential Geometric Approach.
-- | Numeric lift of the toy example.

{-# LANGUAGE MultiParamTypeClasses #-}

module LiftIndex (lifted_rows) where

import Integrator (rk)
import Fiber.R1_PM
import Manifold.R1
import Manifold.R2
import Format
import HoloTypes (Connection, w)

q :: R1 -> R2
q (R1 t) = R2 (t + 1) (-t + 2)

dq :: R1 -> R1 -> R2
dq _ (R1 dt) = R2 (1 * dt) (-1 * dt)

p :: R1 -> R2
p (R1 t) = R2 (-10 * t + 100) (9 * t + 92)

dot :: R2 -> R2 -> Float
dot (R2 a b) (R2 c d) = a*c + b*d

instance Connection R1 R1 TeR1_PM where
  w t dt = TeR1_PM (delta / economy)
    where
      delta = dot (p t) (dq t dt)
      economy = dot (p t) (q t)

-- Lambda(0) = 1
-- The index at t=0 is of course nothing
-- Lambda(1) should be approx. 0.9947
g0 :: R1_PM
g0 = R1_PM 1

ts :: [Float]
ts = [0, 0.01 .. 1]

gamma :: Float -> R1
gamma = R1

m :: R1
ms :: [R1]
(m:ms) = map gamma ts

initial :: (R1, R1_PM)
initial = (m, g0)

lift :: [(R1, R1_PM)]
lift = scanl (rk) initial ms

lifted_rows :: Rows
lifted_rows = Rows $ map (\(R1 a, R1_PM b) -> Row [a, b]) lift
