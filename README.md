# Haskellonomy

![example](media/header.png)

Go checkout [ **src/LiftClassic.hs** ] to see it in action.

This follows from initial work done by Eric Weinstein.

This program is at it's core an ODE solver that respects some group action. The algorithms are in terms of typeclasses for bases and fibers. Some reference implementations are visible for ...

- Fiber
    - U(1)
    - Positive reals under multiplication
    - Reals under addition

- Base manifold
    - R1, R2, R3

## What can't this do yet

Further extensions could be ...
- Levi-Civita connections
- Something with curvature
- General parallel transport of baskets (not just the index multiple)

## How to add a new base manifold or fiber type

The typeclasses are in [ **src/HoloTypes** ].

- Fiber
  - Needs one datatype to have Group
  - Another datatype to have VectorSpace & LieAlgebra
  - This pair then instantiates LieGroup with an exponential map from the LieAlgebra to the Group 

- Manifold
    - Needs to have VectorSpace and BasePoint

## How to run the program

Use [stack](https://docs.haskellstack.org/en/stable/README/)

- stack install (compile to file) or ...
- stack run (run the program) or ...
- stack ghci (use the library interactively)

