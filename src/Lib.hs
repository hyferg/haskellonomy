{-# LANGUAGE ForeignFunctionInterface #-}

module Lib
    ( out
    ) where


import Integrator
import R1A
import R2

data Point = P (R2, R1A)
data Curve = C [Point]

-- combine (manifold direction) (d(fiber)/d(manifold direction))
-- yield a small step in the fiber
step :: R2 -> R2 -> R1A
step h to
  | (R2 dx dy) <- h
  , (R2 x y) <- to
  = R1A (x*dx + y*dy)

-- d(fiber)/d(manifold direction)
w :: R2 -> R2
w (R2 x y) = R2 ((-y)/(1+x*y)) (0)


ts :: [Float]
ts = [0, 0.1 .. tend]

initFiber :: R1A

lift :: (R2, R1A) -> R2 -> (R2, R1A)
lift = (rk (w) (step))

gamma :: Float -> R2


--center initFiber = R1A 2.1
--center tend = 500
--center gamma t = R2
--center   (0.25*sin(t/tend*pi)*cos(2*pi*t)+7.8)
--center   (0.25*sin(t/tend*pi)*sin(2*pi*t)+1.25)

-- right
-- initFiber = R1A 2
-- tend = 120
-- gamma t = R2
--   (0.25*sin(t/tend*pi)*cos(2*pi*t)+8)
--   (0.25*sin(t/tend*pi)*sin(2*pi*t)+1.5)

-- left
-- initFiber = R1A 2
-- tend = 50
-- gamma t = R2
--   (0.25*sin(t/tend*pi)*cos(2*pi*t)+8)
--   (0.25*sin(t/tend*pi)*sin(2*pi*t)+1)



initGamma :: R2
gammas :: [R2]
(initGamma:gammas) = map gamma ts


initCond :: (R2, R1A)
initCond = (initGamma, initFiber)

-- scanl lift (g0, m0) [m1, m2, ...] == [
--  (g0, m0),
--  (g0, m0) `lift` m1,
-- ((g0, m0) `lift` m1) `lift` m2, ...]

--lifted :: [(R2, R1A)]
lifted = scanl lift initCond gammas

--

instance Show Point where
  show (P (R2 a b, R1A c)) =
    (show a) ++ " " ++ (show b) ++ " " ++ (show c) ++ "\n"

instance Show Curve where
  show (C nps) = concat $ map show nps

--out :: IO ()
out = show $ C (map (P) lifted)
