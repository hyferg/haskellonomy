-- | string formatting for export

module Format where
import Data.List

newtype Row = Row [Float]
newtype Rows = Rows [Row]

class ShowCSV x where
  showcsv :: x -> String

class ShowJSON x where
  showjson :: x -> String

instance ShowCSV Row where
  showcsv (Row xs) = (++ "\n") $ unwords (map show xs)

instance ShowCSV Rows where
  showcsv (Rows xs) = concatMap showcsv xs

instance ShowJSON Row where
  showjson (Row xs) = "[" ++ intercalate "," (map show xs) ++ "]"

instance ShowJSON Rows where
  showjson (Rows xs) = "[" ++ intercalate "," (map showjson xs) ++ "]"
