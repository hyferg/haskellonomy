{-# LANGUAGE MultiParamTypeClasses #-}

module LiftU1 (lift) where

import Integrator (rk)
import Manifold.R2
import Fiber.U1
import Data.Complex
import Format
import HoloTypes (Connection, w)

g0 :: U1
g0 = U1 (1 :+ 0)

ts :: [Float]
ts = [0, 0.005 .. 2]

gamma :: Float -> R2
gamma t = R2 x y
  where
    radius = 5
    scale = 1 + 0.25 * cos(2 * pi * 3 * t)
    x = scale * radius * cos(2 * pi * t)
    y = scale * radius * sin(2 * pi * t)

instance Connection R2 R2 TeU1 where
  w (R2 x _) (R2 dx dy) = TeU1 (w0*dx + w1*dy)
      where
        w0 = 0
        w1 = 0.35 * x

m :: R2
ms :: [R2]
(m:ms) = map gamma ts

initial :: (R2, U1)
initial = (m, g0)

lift :: [(R2, U1)]
lift = scanl (rk) initial ms

lifted_rows :: Rows
lifted_rows = Rows $ map (\(R2 a b, U1 c) -> Row [a, b, phase c]) lift
