type 
  Matrix*[H:int, W:int] = array[H, array[W, int]]

# Get
proc `[]`*(m: Matrix, y: int, x: int): int = 
  if y < m.size()[0] and x < m.size()[1]:
    return m[y][x]
  else:
    return 0;

# Set
proc `[]=`*(m: var Matrix, y: int, x: int, val: int) = 
  if y < m.size()[0] and x < m.size()[1]:
    m[y][x] = val;

# Size
proc size*(m: Matrix): (int, int) = 
  return (len(m), len(m[0]))

# Is equal
proc `==`*(m: Matrix, n: Matrix): bool = 
  var b: bool = true;

  # Same size
  if m.size() != n.size:
    b = false;
  # Check every number
  var r = 0;
  var c = 0;
  while r < m.size()[0]:
    while c < m.size()[1]:
      if m[r,c] != n[r,c]:
        b = false;
      c = c+1;
    r = r+1;
  return b;

# Add
proc `+`*(m: Matrix, n: Matrix): Matrix =
  var o: Matrix;
  if(m.size() != n.size()):
    echo "Error when adding matrix. The given matrixes don't have the same lengh."
    return o;
  var r = 0;
  var c = 0;
  while r < m.size()[0]:
    while c < m.size()[1]:
      o[r,c] = m[r,c] + n[r,c];
      c = c+1;
    r = r+1;
  return o;

# Subract
proc `-`*(m: Matrix, n: Matrix): Matrix =
  var o: Matrix;
  if(m.size() != n.size()):
    echo "Error when subtractinb matrix. The given matrixes don't have the same lengh."
    return o;
  var r = 0;
  var c = 0;
  while r < m.size()[0]:
    while c < m.size()[1]:
      o[r,c] = m[r,c] - n[r,c];
      c = c+1;
    r = r+1;
  return o;