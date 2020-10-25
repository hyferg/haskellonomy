{-# LANGUAGE ForeignFunctionInterface #-}

module Lib
    ( out
    ) where

import Foreign.C.Types
import Integrator
import HoloTypes
import R2P

f :: R2P -> FiberPoint -> R2P
f (R2P (u1, u2)) _ = R2P (2*u1, 2*u2)

ts :: [Float]
ts = [0, 0.0001 .. 3]

gamma :: Float -> R2P
gamma t = R2P ((1 / sqrt 2) * t, (1 / sqrt 2) * t)

initGamma :: R2P
gammas :: [R2P]
(initGamma:gammas) = map gamma ts

initFiber :: FiberPoint
initFiber = 0

initCond :: (R2P, FiberPoint)
initCond = (initGamma, initFiber)

lifted :: [(R2P, FiberPoint)]
lifted = scanl (rk f) initCond gammas

--

out :: IO ()
out = putStrLn $ show lifted

-- Very simple haskell function
hsfun :: CInt -> IO CInt
hsfun x = do
    putStrLn "Hello World"
    return (42 + x)

foreign export ccall
    hsfun :: CInt -> IO CInt
