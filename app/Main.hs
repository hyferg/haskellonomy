module Main where

import LiftIndex
import Format

main :: IO ()
main = do
  writeFile "./data/liftIndex.txt" (showcsv lifted)
