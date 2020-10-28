{-# LANGUAGE MultiParamTypeClasses #-}
-- | Fiber for group of positive reals under multiplication

module R1M where

import Data.Group
import HoloTypes

data R1 = R1 Float deriving(Show)
data TeR1 = TeR1 Float deriving(Show)

instance Semigroup R1 where
  (<>) (R1 a) (R1 b) = R1 (a * b)

instance Monoid R1 where
  mempty = R1 1

instance Group R1 where
  invert (R1 a) = R1 (1/a)

instance VectorSpace TeR1 where
  origin = TeR1 0
  (^+^) (TeR1 a) (TeR1 b) = TeR1 (a+b)
  (^*) (TeR1 a) s = TeR1 (s*a)
  (*^) s (TeR1 a) = TeR1 (s*a)
  _invert (TeR1 a) = (TeR1 (-a))

instance LieAlgebra TeR1

instance LieGroup (TeR1) (R1) where
  exponential (TeR1 a) = R1 $ exp a

