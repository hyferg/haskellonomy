from ctypes import *

lib = CDLL("./build/HoloLib.so")

# Test simple function
print(lib.hsfun(5))
