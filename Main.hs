module Main where

import Diagrams.Backend.Rasterific.CmdLine
import Diagrams.Prelude

-- | Shape used to build the Sierpinski triangle
data Shape =
  Square
  | Circle
  | Triangle
  deriving (Show, Read, Eq)

-- | Turn shape into a diagram
shape :: Shape -> Diagram B R2
shape Square = square 1
shape Circle = circle 1
shape Triangle = triangle 1

-- | Style of diagram
style sh = sh
    # fc red
    # lwL 0

-- | Concatenate 3 diagrams into a sierpinsky triangle
sierpinski :: Diagram B R2 -> Diagram B R2
sierpinski dia = vcat [dia', (dia' ||| dia') # centerXY]
  where dia' =  dia # scale 0.5

main = mainWith $ \sh n ->
  let dia = style . shape . read $ sh
      triangles = iterate sierpinski dia
  in triangles !! n # bg white
