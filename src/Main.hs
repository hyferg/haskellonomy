module Main where

import LiftIndex
import Format

main :: IO ()
main = do
  writeFile "./data-out/liftIndex.txt" (showcsv lifted)
