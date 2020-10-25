-- |

module Integrator
  ( euler, rk
  ) where

import HoloTypes

euler :: (BasePoint bp) =>
         (bp -> FiberPoint -> bp) ->
         (bp, FiberPoint) -> bp -> (bp, FiberPoint)
euler f (t, y) t' = (t', y + h `dot` f t y)
    where
    h = t' ^-^ t

rk :: (BasePoint bp) =>
      (bp -> FiberPoint -> bp) ->
      (bp, FiberPoint) -> bp -> (bp, FiberPoint)
rk f (t, y) t' = (t', y + h`dot`(k1 ^+^ (2.0*^k2) ^+^ (2.0*^k3) ^+^ k4)/6.0)
    where
        h  = t' ^-^ t
        k1 = f t y
        k2 = f (t ^+^ (0.5*^h)) (y + 0.5*^h`dot`k1)
        k3 = f (t ^+^ (0.5*^h)) (y + 0.5*^h`dot`k2)
        k4 = f (t ^+^ (1.0*^h)) (y + 1.0*^h`dot`k3)
