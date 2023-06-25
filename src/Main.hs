module Main where

import LiftIndex (lifted)
import Format
import System.Directory (canonicalizePath)

path = "./data-out/liftIndex.txt"
theLift = lifted

-- write lift to file and log to console that we're done
main :: IO ()
main = do
  fullPath <- canonicalizePath path
  writeFile path (showcsv theLift)
  putStrLn ("Wrote lift to file: " ++ fullPath)