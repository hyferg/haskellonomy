-- | Constraints for objects used in a fiber integrator.
-- | These keep everything safe and closer to rigor than not.

{-# LANGUAGE FunctionalDependencies #-}

module HoloTypes (
  VectorSpace,
  (^*), (*^), (^+^), (^-^), _invert, origin,
  ManifoldPoint,
  LieAlgebra,
  LieGroup,
  exponential, (|>), (<|),
  Connection, w
  ) where

import Data.Group

class VectorSpace v where
  origin :: v
  (^*) :: v -> Float -> v
  (*^) :: Float -> v -> v
  (^+^), (^-^)  :: v -> v -> v
  _invert :: v -> v

  (^-^) p1 p2 = p1 ^+^ _invert p2
  _invert p1 = origin ^-^ p1

-- in a Euclidean neighborhood
class (VectorSpace m) => ManifoldPoint m

class (VectorSpace l) => LieAlgebra l

class (VectorSpace m, VectorSpace te, LieAlgebra le) => Connection m te le where
  w :: m -> te -> le

-- The Lie group uniquely determines the Lie algebra which is encoded in 'g -> l'
-- See the Lie group–Lie algebra correspondence
class (LieAlgebra l, Group g) => LieGroup l g | g -> l where
  exponential :: l -> g
  (|>) :: g -> g -> g
  (<|) :: g -> g -> g

  -- right and left group actions
  (|>) = (<>)
  (<|) e g = invert g |> e
