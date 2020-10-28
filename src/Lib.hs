module Lib (out) where

import Integrator
import R2
import R1M

-- initial group section
g0 :: R1
g0 = R1 2

-- parameters of g(t) curve
ts :: [Float]
ts = [0, 0.01 .. 4]

-- g(t) parametric curve
gamma :: Float -> R2
gamma t = R2
  (cos(2*pi*t)+2)
  (sin(2*pi*t)+2)

-- local representation of a connection, a YM field
w :: R2 -> R2 -> TeR1
w (R2 x y) (R2 dx dy) = TeR1 (w0*dx + w1*dy)
    where
      w0 = (-y)/(1+x*y)
      w1 = 0

--

m  ::  R2
ms :: [R2]
(m:ms) = map gamma ts

initial :: (R2, R1)
initial = (m, g0)

--

-- The main algorithm is a scan over the base curve.
-- This approximates the path ordered exponential
-- solution to the ODE for the curve in g.
-- We collect all intermediate terms with the scan
-- so that we can plot the curve up to the final point
--
-- scanl lift (g0, m0) [m1, m2, ...] = [
--  (m0, g0),
--  (m0, g0) `lift` m1,
-- ((m0, g0) `lift` m1) `lift` m2, ...]
--
-- ..or..
--
-- scanl lift (g0, m0) [m1, m2, ...] = [
-- (m0, g0),
-- (m1, g1 <> g0),
-- (m2, g2 <> g1 <> g0),
-- ...
-- (mn, gn <> .. <> g1 <> g0),
--
-- where <> is the group action and `mn` is the last point
-- in the base manifold curve

lifted :: [(R2, R1)]
lifted = scanl (rk w) initial ms

-- format string for numpy.loadtxt

data Point = P (R2, R1)
data Curve = C [Point]

instance Show Point where
  show (P (R2 a b, R1 c)) =
    (show a) ++ " " ++ (show b) ++ " " ++ (show c) ++ "\n"
 
instance Show Curve where
   show (C nps) = concat $ map show nps

-- ship the formatted string

out :: String
out = show $ C $ map (P) lifted
