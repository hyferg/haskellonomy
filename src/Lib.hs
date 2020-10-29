module Lib (lift, hori) where

import Integrator (rk)
import Manifold.R2
import Fiber.R1_PM
import Data.List

-- initial group section
g0 :: R1_PM
g0 = R1_PM 2

-- parameters of g(t) curve
ts :: [Float]
ts = [0, 0.01 .. 4]

-- g(t) parametric curve
gamma :: Float -> R2
gamma t = R2
  (cos(2*pi*t)+2)
  (sin(2*pi*t)+2)

-- local representation of a connection, a YM field
w :: R2 -> R2 -> TeR1_PM
w (R2 x y) (R2 dx dy) = TeR1_PM (w0*dx + w1*dy)
    where
      w0 = (-y)/(1+x*y)
      w1 = 0

--

m  ::  R2
ms :: [R2]
(m:ms) = map gamma ts

initial :: (R2, R1_PM)
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

lifted :: [(R2, R1_PM)]
lifted = scanl (rk w) initial ms

-- format string for numpy.loadtxt

lift :: String
lift = showjson $ Rows $ map (\(R2 a b, R1_PM c) -> Row [a, b, c]) lifted

hori :: String
hori = showjson $ Rows $ horizontals lifted

--

-- (x, y, z, unit dx, unit dy)
horizontals :: [(R2, R1_PM)] -> [Row]
horizontals curve = polys
  where

    xs = map (\(R2 x _, _) -> x) curve
    ys = map (\(R2 _ y, _) -> y) curve
    zs = map (\(_, R1_PM z) -> z) curve

    range :: Float -> Float -> Float -> [Float]
    range lower step upper =
      map (\x -> x*(upper-lower) + lower) [0, step .. 1]

    xgrid = range (minimum xs) 0.33 (maximum xs)
    ygrid = range (minimum ys) 0.33 (maximum ys)
    zgrid = range (0) 0.15 (maximum zs)

    lie (TeR1_PM a) = a

    polys = [ Row [ x, y, z,
                    z * (lie $ w (R2 x y) (R2 1 0)),
                    z * (lie $ w (R2 x y) (R2 0 1)) ]
            | x <- xgrid, y <- ygrid, z <- zgrid ]

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
