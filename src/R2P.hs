-- | R^{2} Flat Base Manifold

module R2P where

import HoloTypes

data R2P = R2P (Float, Float)

instance BasePoint R2P where
    dot    (R2P (a, b)) (R2P (c, d)) = a*c + b*d
    (^+^)  (R2P (a, b)) (R2P (c, d)) = R2P (a+c, b+d)
    (^-^)  (R2P (a, b)) (R2P (c, d)) = R2P (a-c, b-d)
    (^*)   (R2P (a, b)) s            = R2P (s*a, s*b)
    (*^) s (R2P (a, b))              = R2P (s*a, s*b)


instance Show R2P where
  show (R2P (a, b)) = "(" ++ (show a) ++ "," ++ (show b) ++ ")"
