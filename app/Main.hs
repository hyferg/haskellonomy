module Main where

import U1Curve

main :: IO ()
main = do
  writeFile "./app/liftU1.txt" lift
