-- | Fiber for group of R^{1} under addition

module R1A where

import Data.Group
import HoloTypes

data R1A = R1A Float deriving(Show)

instance Semigroup R1A where
  (<>) (R1A a) (R1A b) = R1A (a + b)

instance Monoid R1A where
  mempty = R1A 0

instance Group R1A where
  invert (R1A a) = R1A (-a)

instance VectorSpace R1A where
  origin = R1A 0
  (^+^) (R1A a) (R1A b) = R1A (a+b)
  (^*) (R1A a) s = R1A (s*a)
  (*^) s (R1A a) = R1A (s*a)
  _invert = invert

instance FiberPoint R1A
