import sequtils

type 
  Matrix*[H:int, W:int] = array[H, array[W, int]]

# Get
proc `[]`(m: Matrix, y: int, x: int): int = 
  return m[y][x]
