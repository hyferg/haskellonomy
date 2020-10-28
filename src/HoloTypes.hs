-- |

module HoloTypes (
  (^*), (*^), (^+^), (^-^), _invert, origin,
  BasePoint,
  FiberPoint, exponential,
  VectorSpace,
  ) where

import Data.Group

class VectorSpace v where
  origin :: v
  (^*) :: v -> Float -> v
  (*^) :: Float -> v -> v
  (^+^), (^-^)  :: v -> v -> v
  _invert :: v -> v

  (^-^) p1 p2 = p1 ^+^ (_invert p2)
  _invert p1 = origin ^-^ p1

-- in a Euclidean neighborhood
class (VectorSpace p) => BasePoint p

-- addition is not defined on the group
-- with a hand wave, it is defined in the linearisation
-- (^+^) is a linear approximation of movement in the group
-- (^+^) :: ( G, T_{e}G ) --> G
-- (^+^) :: (g, A) |--> g + A
-- where A is small
class (Group f, VectorSpace f) => FiberPoint f where
  exponential :: f -> f
