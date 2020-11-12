-- | Constraints for objects used in a fiber integrator.
-- | These keep everything safe and closer to rigor than not.

{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FunctionalDependencies #-}

module HoloTypes (
  VectorSpace,
  (^*), (*^), (^+^), (^-^), _invert, origin,
  BasePoint,
  LieAlgebra,
  LieGroup,
  exponential, (|>), (<|)
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
class (VectorSpace m) => BasePoint m

class (VectorSpace l) => LieAlgebra l

class (LieAlgebra l, Group g) => LieGroup l g | g -> l where
  exponential :: l -> g
  (|>) :: g -> g -> g
  (<|) :: g -> g -> g

  (|>) = (<>)
  (<|) e g = (invert g) |> e
