-- |

module Integrator
  ( euler, rk
  ) where

import HoloTypes

euler :: (BasePoint m, FiberPoint g) =>
        (m -> m) -> (m -> m -> g) -> (m, g) -> m -> (m, g)
euler w step (m, g) m' = (m', g ^+^ g')
  where
    h = m' ^-^ m
    g' = h `step` w m


rk :: (BasePoint m, FiberPoint g) =>
        (m -> m) -> (m -> m -> g) -> (m, g) -> m -> (m, g)
rk w step (m, g) m' = (m', exponential g' <> g )
  where
    h = m' ^-^ m

    k1 = w m
    k2 = w ( m ^+^ (0.5*^h ) )
    k3 = w ( m ^+^ (0.5*^h ) )
    k4 = w ( m ^+^ (1.0*^h ) )

    g' = h `step` (k1 ^+^ (2.0*^k2) ^+^ (2.0*^k3) ^+^ k4)^*(1.0/6.0)
