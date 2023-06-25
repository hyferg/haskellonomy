module Main where

import LiftIndex
import Format
import System.Directory (canonicalizePath)

path = "./data-out/liftIndex.txt"
theLift = lifted

-- write lift to file and log to console that we're done
main :: IO ()
main = do
  writeFile path (showcsv theLift)
  fullPath <- canonicalizePath path
  putStrLn ("Wrote lift to file: " ++ fullPath)