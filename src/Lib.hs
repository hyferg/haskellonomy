{-# LANGUAGE ForeignFunctionInterface #-}

module Lib
    ( out
    ) where

import Integrator
import R1A
import R2

-- combine (manifold direction) (d(fiber)/d(manifold direction))
-- yield a small step in the fiber
step :: R2 -> R2 -> R1A
step h to
  | (R2 dx dy) <- h
  , (R2 x y) <- to
  = R1A (x*dx + y*dy)

-- d(fiber)/d(manifold direction)
w :: R2 -> R2
w (R2 x y) = R2 (2*x) (2*y)

ts :: [Float]
ts = [0, 0.01 .. 1]

lift :: (R2, R1A) -> R2 -> (R2, R1A)
lift = (rk (w) (step))

gamma :: Float -> R2
gamma t = R2 ((1 / sqrt 2) * t) ((1 / sqrt 2) * t)

initGamma :: R2
gammas :: [R2]
(initGamma:gammas) = map gamma ts

initFiber :: R1A
initFiber = R1A 0

initCond :: (R2, R1A)
initCond = (initGamma, initFiber)

-- scanl lift (g0, m0) [m1, m2, ...] == [
--  (g0, m0),
--  (g0, m0) `lift` m1,
-- ((g0, m0) `lift` m1) `lift` m2, ...]

--lifted :: [(R2, R1A)]
lifted = last $ scanl lift initCond gammas

--

out :: IO ()
out = putStrLn $ show lifted
