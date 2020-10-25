-- |

module HoloTypes where

--type BasePoint = (Float, Float)
type FiberPoint = Float

class BasePoint bp where
  (^+^), (^-^)  :: bp -> bp -> bp
  (^*) :: bp -> Float -> bp
  (*^) :: Float -> bp -> bp
  dot :: bp -> bp -> FiberPoint
