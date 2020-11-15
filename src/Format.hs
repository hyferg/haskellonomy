-- |

module Format where
import Data.List

data Row = Row [Float]
data Rows = Rows [Row]

-- string formatting methods

class ShowCSV x where
  showcsv :: x -> String

class ShowJSON x where
  showjson :: x -> String

instance ShowCSV Row where
  showcsv (Row xs) = (++ "\n") $ concat (intersperse " " (map show xs))

instance ShowCSV Rows where
  showcsv (Rows xs) = concat $ map showcsv xs

instance ShowJSON Row where
  showjson (Row xs) = "[" ++ (concat $ intersperse "," (map show xs)) ++ "]"

instance ShowJSON Rows where
  showjson (Rows xs) = "[" ++ (concat $ intersperse "," (map showjson xs)) ++ "]"
