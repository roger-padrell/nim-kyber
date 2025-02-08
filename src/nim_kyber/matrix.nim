type
  List* = array[4, int]
  Matrix*[H: int] = array[H,List]

proc modByModN(n: int): int =
  let m = n mod 31
  if m >= 16:
    m - 31
  elif m <= -16:
    m + 31
  else: 
    m

proc clamp*(x: int): int =
  ## Clamps a value to the range [-15, 15] using modulo 31 arithmetic.
  let m = x mod 31
  if m > 15:
    return m - 31
  elif m < -15:
    return m + 31
  else:
    return m

proc rotateRight(arr: List, n: int): List =
  ## Rotates an array to the right by `n` positions, with sign changes for wrapped elements.
  let n = n mod 4
  if n == 0:
    return arr
  var res: List
  for i in 0..<4:
    let newPos = (i + n) mod 4
    res[newPos] = arr[i]
    if newPos < n:
      res[newPos] = -res[newPos]  # Change sign for wrapped elements
  return res

proc `*`*(a, b: List): List =
  ## Multiplies two 4-element arrays using the specified rules.
  var sum: List = [0, 0, 0, 0]
  for i in 0..3:
    var term: List
    for j in 0..3:
      term[j] = a[j] * b[i]
    var rotated = rotateRight(term, i)
    for k in 0..3:
      rotated[k] = clamp(rotated[k])
    for k in 0..3:
      sum[k] += rotated[k]
  for k in 0..3:
    sum[k] = clamp(sum[k])
  return sum


proc `+`*(a, b: List): List =
  ## Adds two 4-element arrays and clamps the result.
  for i in 0..3:
    result[i] = clamp(a[i] + b[i])

proc `-`*(a, b: List): List =
  for i in 0..3:
    result[i] = modByModN(a[i] - b[i])

proc `[]`*(m: Matrix, y: int, x:int): int = 
  m[y][x]

proc `[]=`*(m: var Matrix, y: int, x: int, val: int) = 
  m[y][x] = val;