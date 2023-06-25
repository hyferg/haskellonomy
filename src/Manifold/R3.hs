-- | R^{3} flat base manifold

module Manifold.R3 where

import HoloTypes

data R3 = R3 Float Float Float deriving (Show)

instance VectorSpace R3 where
  origin = R3 0 0 0
  (^+^) (R3 a b c) (R3 d e f) = R3 (a + d) (b + e) (c + f)
  (^*) (R3 a b c) s = R3 (s * a) (s * b) (s * c)
  (*^) s (R3 a b c) = R3 (s * a) (s * b) (s * c)
  _invert (R3 a b c) = R3 (-a) (-b) (-c)

instance ManifoldPoint R3
