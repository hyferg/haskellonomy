module Main where

import Lib

main :: IO ()
main = do
  writeFile "./app/hori.txt" hori
  writeFile "./app/lift.txt" lift
