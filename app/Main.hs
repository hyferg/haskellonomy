module Main where

import Lib

main :: IO ()
main = do
  writeFile "./app/out.txt" out
