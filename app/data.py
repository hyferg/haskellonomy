"""
example of how to ship data to haskell and back
useful later for live interfacing with the ODE solver
"""
from ctypes import POINTER, CDLL, c_float
import numpy as np

lib = CDLL("./build/HoloLib.so")

__xs = np.linspace(0, 1, 5)
LEN_XS = len(__xs)
_xs = (c_float * LEN_XS)(*__xs)

lib.reverseList.restype = POINTER(c_float)
xs = lib.reverseList(LEN_XS, _xs)

xsnp = np.ctypeslib.as_array(xs, shape=[LEN_XS])


class R2Lift(Structure):
    _fields_ = [("x", c_float), ("y", c_float), ("z", c_float)]
