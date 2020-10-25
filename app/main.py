from ctypes import *

lib = CDLL("./build/HoloLib.so")

# Test simple function
# print(lib.hsfun(5))

#   lib.aList.restype = POINTER(c_float)
#   xs = lib.aList()
#   for i in range(3):
#       print(xs[i])


lib.reverseList.restype = POINTER(c_float)
__xs = [1.0, 2.0, 3.0]
_xs = (c_float * 3)(*__xs)
xs = lib.reverseList(len(_xs), _xs)

for i in range(len(_xs)):
    print(xs[i])
