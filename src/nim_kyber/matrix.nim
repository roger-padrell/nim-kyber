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

proc generateComponent(a: List, multiplier: int, shift: int): List =
  var multiplied: List
  for i in 0..3:
    multiplied[i] = modByModN(a[i] * multiplier)
  
  let k = shift mod 4
  var shifted: List
  
  # Handle the wrapped elements with sign change
  for i in 0..<k:
    let idx = 4 - k + i
    shifted[i] = modByModN(-multiplied[idx])
  
  # Handle the remaining elements
  for i in k..3:
    shifted[i] = multiplied[i - k]
  
  shifted

proc `+`*(a, b: List): List =
  for i in 0..3:
    result[i] = modByModN(a[i] + b[i])

proc `-`*(a, b: List): List =
  for i in 0..3:
    result[i] = modByModN(a[i] - b[i])

proc `*`*(a, b: List): List =
  var components: array[4, List]
  
  # Generate all four components
  for k in 0..3:
    components[k] = generateComponent(a, b[k], k)
  
  # Sum all components
  for i in 0..3:
    var sum = 0
    for component in components:
      sum += component[i]
    result[i] = modByModN(sum)

proc `[]`*(m: Matrix, y: int, x:int): int = 
  m[y][x]

proc `[]=`*(m: var Matrix, y: int, x: int, val: int) = 
  m[y][x] = val;