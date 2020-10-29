-- | Example of how to export shared library.
-- | Useful later if the integrator needs to be used in realtime.

{-# LANGUAGE ForeignFunctionInterface #-}

module Util.FFIFns where

import Foreign.Ptr
import Foreign.C.Types
import Foreign.Marshal.Array

reverseList :: CInt -> (Ptr Float) -> IO (Ptr Float)
reverseList len lst_f = do
  fs <- peekArray (fromIntegral len) lst_f
  newArray $ reverse fs

foreign export ccall
  reverseList :: CInt -> (Ptr Float) -> IO (Ptr Float)
