-- | R^{1} flat base manifold

module Manifold.R1 where

import HoloTypes

newtype R1 = R1 Float deriving (Show)

instance VectorSpace R1 where
  origin = R1 0
  (^+^) (R1 a) (R1 b) = R1 (a + b)
  (^*) (R1 a) s = R1 (s * a)
  (*^) s (R1 a) = R1 (s * a)
  _invert (R1 a) = R1 (-a)

instance ManifoldPoint R1
