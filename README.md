# Haskellonomy

![example](media/header.png)

Go check out [ **src/LiftClassic.hs** ] to see it in action.

This follows from initial work done by Eric Weinstein.

This program is at its core an ODE solver that respects some group action. The algorithms are in terms of typeclasses for bases and fibers. Some reference implementations are visible for ...

- Fibers:
  - U(1)
  - Positive reals under multiplication
  - Reals under addition

- Base manifolds:
  - R1, R2, R3

## What it can't do yet
- Levi-Civita connections
- Other base manifolds beyond R^n
- General parallel transport of economic (src/LiftIndex.hs) baskets (not just the index multiple)

## How to add a new base manifold or fiber type

The typeclasses are in [ **src/HoloTypes** ].

- Fibers are Lie groups so instantiate

  - LieAlgebra
  - Group
  - An exponential map from the algebra to the group
  - And now you have a LieGroup

- Manifold
  - Needs to have VectorSpace and BasePoint

## How to run the program

Use [stack](https://docs.haskellstack.org/en/stable/README/)

- stack install (compile to file) or ...
- stack run (run the program) or ...
- stack ghci (use the library interactively)
