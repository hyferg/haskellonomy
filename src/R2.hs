-- | R^{2} Flat Base Manifold

module R2 where

import HoloTypes

data R2 = R2 Float Float deriving(Show)

instance VectorSpace R2 where
  origin = R2 0 0
  (^+^) (R2 a b) (R2 c d) = R2 (a+c) (b+d)
  (^*) (R2 a b) s = R2 (s*a) (s*b)
  (*^) s (R2 a b) = R2 (s*a) (s*b)
  _invert (R2 a b) = R2 (-a) (-b)

instance BasePoint R2
