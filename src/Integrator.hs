-- | Euler and Runge-Kutta integrators.
-- | These use the left group action for stepped changes on assc. bundles.
--
-- | The ability to choose some linear left action lets us sneak in
-- | negative signs where desired.
--
-- | In principle for a principal bundle, the right action could be used.

module Integrator
  ( euler, rk
  ) where

import HoloTypes
import Data.Group

-- eulerConnection :: (Connection m te le, LieGroup le g) =>  (m, g) -> m -> (m, g)
eulerConnection (m, g) m' = (m', g' |> g)
  where
    dm = m' ^-^ m
    e' = w m dm
    g' = exponential e'

euler :: (ManifoldPoint m, LieGroup l g) =>

  (m -> m -> l) -> (m, g) -> m -> (m, g)

euler w (m, g) m' = (m', g' |> g)
  where
    dm = m' ^-^ m
    e' = w m dm
    g' = exponential e'


rk :: (ManifoldPoint m, LieGroup l g) =>

  (m -> m -> l) -> (m, g) -> m -> (m, g)

rk w (m, g) m' = (m', g' |> g)
  where
    dm = m' ^-^ m

    k1 = w m
    k2 = w $ m ^+^ (dm ^* 0.5)
    k3 = w $ m ^+^ (dm ^* 0.5)
    k4 = w $ m ^+^ (dm ^* 1.0)

    e' = (1.0/6.0) *^ (
      (k1 dm) ^+^
      (k2 dm ^* 2) ^+^
      (k3 dm ^* 2) ^+^
      (k4 dm) )
        
    g' = exponential e'
