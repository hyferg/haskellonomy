module U1Curve (lift) where

import Integrator (rk)
import Manifold.R2
import Fiber.U1
import Data.List
import Data.Complex

-- initial group section
g0 :: U1
g0 = U1 (1 :+ 0)

-- parameters of g(t) curve
ts :: [Float]
ts = [0, 0.005 .. 2]

-- g(t) parametric curve
gamma :: Float -> R2
gamma t = R2 x y
  where
    radius = 5
    scale = 1 + 0.25 * cos(2 * pi * 3 * t)
    x = scale * radius * cos(2 * pi * t)
    y = scale * radius * sin(2 * pi * t)

-- local representation of a connection, a YM field
w :: R2 -> R2 -> TeU1
w (R2 x _) (R2 dx dy) = TeU1 (w0*dx + w1*dy)
    where
      w0 = 0
      w1 = 0.35 * x

--

m  ::  R2
ms :: [R2]
(m:ms) = map gamma ts

initial :: (R2, U1)
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

lifted :: [(R2, U1)]
lifted = scanl (rk w) initial ms

-- format string for numpy.loadtxt

lift :: String
lift = showjson $ Rows $ map (\(R2 a b, U1 c) -> Row [a, b, phase c]) lifted

-- string formatting methods

data Row = Row [Float]
data Rows = Rows [Row]

class ShowCSV x where
  showcsv :: x -> String

class ShowJSON x where
  showjson :: x -> String

instance ShowCSV Row where
  showcsv (Row xs) = (++ "\n") $ concat (intersperse " " (map show xs))

instance ShowCSV Rows where
  showcsv (Rows xs) = concat $ map showcsv xs

instance ShowJSON Row where
  showjson (Row xs) = "[" ++ (concat $ intersperse "," (map show xs)) ++ "]"

instance ShowJSON Rows where
  showjson (Rows xs) = "[" ++ (concat $ intersperse "," (map showjson xs)) ++ "]"
