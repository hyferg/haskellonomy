-- | The circle group

{-# LANGUAGE MultiParamTypeClasses #-}

module Fiber.U1 where

import Data.Group
import Data.Complex
import HoloTypes

data U1 = U1 (Complex Float) deriving (Show)
data TeU1 = TeU1 Float  deriving (Show)

instance Semigroup U1 where
  (<>) (U1 a) (U1 b) = U1 (a * b)

instance Monoid U1 where
  mempty = U1 (1 :+ 0)

instance Group U1 where
  invert (U1 a) = U1 (-a)

instance VectorSpace TeU1 where
  origin = TeU1 0
  (^+^) (TeU1 theta_0) (TeU1 theta_1) = TeU1 (theta_0 + theta_1)
  (^*) (TeU1 theta) s = TeU1 (s * theta)
  (*^) s (TeU1 theta) = TeU1 (s * theta)
  _invert (TeU1 theta) = TeU1 (-theta)

instance LieAlgebra TeU1

instance LieGroup (TeU1) (U1) where
  exponential (TeU1 theta) = U1 $ exp $ 0 :+ theta
