-- | Fiber for group of positive reals under multiplication

{-# LANGUAGE MultiParamTypeClasses #-}

module Fiber.R1_PM where

import Data.Group
import HoloTypes

data R1_PM = R1_PM Float deriving (Show)
data TeR1_PM = TeR1_PM Float deriving (Show)

instance Semigroup R1_PM where
  (<>) (R1_PM a) (R1_PM b) = R1_PM (a * b)

instance Monoid R1_PM where
  mempty = R1_PM 1

instance Group R1_PM where
  invert (R1_PM a) = R1_PM (1/a)

instance VectorSpace TeR1_PM where
  origin = TeR1_PM 0
  (^+^) (TeR1_PM a) (TeR1_PM b) = TeR1_PM (a+b)
  (^*) (TeR1_PM a) s = TeR1_PM (s*a)
  (*^) s (TeR1_PM a) = TeR1_PM (s*a)
  _invert (TeR1_PM a) = (TeR1_PM (-a))

instance LieAlgebra TeR1_PM

instance LieGroup (TeR1_PM) (R1_PM) where
  exponential (TeR1_PM a) = R1_PM $ exp a
