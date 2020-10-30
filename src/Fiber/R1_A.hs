-- | Group of reals under addition

{-# LANGUAGE MultiParamTypeClasses #-}

module Fiber.R1_A where

import Data.Group
import HoloTypes

data R1_A = R1_A Float deriving (Show)
data TeR1_A = TeR1_A Float deriving (Show)

instance Semigroup R1_A where
  (<>) (R1_A a) (R1_A b) = R1_A (a + b)

instance Monoid R1_A where
  mempty = R1_A 0

instance Group R1_A where
  invert (R1_A a) = R1_A (-a)

instance VectorSpace TeR1_A where
  origin = TeR1_A 0
  (^+^) (TeR1_A a) (TeR1_A b) = TeR1_A (a+b)
  (^*) (TeR1_A a) s = TeR1_A (s*a)
  (*^) s (TeR1_A a) = TeR1_A (s*a)
  _invert (TeR1_A a) = (TeR1_A (-a))

instance LieAlgebra TeR1_A

instance LieGroup (TeR1_A) (R1_A) where
  exponential (TeR1_A a) = R1_A $ a
