import consts, strutils, parseutils

type
  List* = array[listSize, int]
  Matrix*[H: int] = array[H,List]

proc clamp*(x: int): int =
  let m = x mod (abs(clampingRange[0])+clampingRange[1]+1)
  if m > clampingRange[1]:
    return m - (abs(clampingRange[0])+clampingRange[1]+1)
  elif m < clampingRange[0]:
    return m + (abs(clampingRange[0])+clampingRange[1]+1)
  else:
    return m

proc fill*(a: List, n: int): List = 
  var b: List = a;
  var c = 0;
  while c < listSize:
    b[c] = c;
    c = c+1;
  return b;

proc rotateRight(arr: List, n: int): List =
  ## Rotates an array to the right by `n` positions, with sign changes for wrapped elements.
  let k = n mod listSize
  if k == 0:
    return arr
  var res: List
  for i in 0..<listSize:
    let newPos = (i + k) mod listSize
    res[newPos] = arr[i]
    if newPos < k:
      res[newPos] = -res[newPos]  # Negate elements that wrapped around
  return res

proc `*`*(a, b: List): List =
  ## Multiplies two `listSize`-element arrays using the specified rules.
  assert a.len == listSize and b.len == listSize, 
    "Lists must have exactly " & $listSize & " elements"
  
  var sum: List
  for i in 0..<listSize:
    var term: List
    for j in 0..<listSize:
      term[j] = a[j] * b[i]
    let rotated = rotateRight(term, i)
    for k in 0..<listSize:
      sum[k] += clamp(rotated[k])
  for k in 0..<listSize:
    sum[k] = clamp(sum[k])
  return sum


proc `+`*(a, b: List): List =
  for i in 0..(listSize-1):
    result[i] = clamp(a[i] + b[i])

proc `-`*(a, b: List): List =
  for i in 0..(listSize-1):
    result[i] = clamp(a[i] - b[i])

proc `[]`*(m: Matrix, y: int, x:int): int = 
  m[y][x]

proc `[]=`*(m: var Matrix, y: int, x: int, val: int) = 
  m[y][x] = val;

proc parse4Matrix*(fromString: string): Matrix[4] = 
  var splitted = fromString.split(",");
  var res: Matrix[4];
  var n = 0;
  var list = 0;
  var item = 0;
  while n<splitted.len:
    var replaced = splitted[n].replace("[","").replace("]","").replace("(","").replace(")","").replace(" ","")
    var num: int;
    discard parseInt(replaced, num, 0);
    res[list][item] = num;

    # Change list, item and n
    n = n + 1;
    item = n mod listSize;
    list = ((n - item) / listSize).toInt;
  return res;

proc parse2Matrix*(fromString: string): Matrix[2] = 
  var splitted = fromString.split(",");
  var res: Matrix[2];
  var n = 0;
  var list = 0;
  var item = 0;
  while n<splitted.len:
    var replaced = splitted[n].replace("[","").replace("]","").replace("(","").replace(")","").replace(" ","")
    var num: int;
    discard parseInt(replaced, num, 0);
    res[list][item] = num;

    # Change list, item and n
    n = n + 1;
    list = ((n - (n mod listSize)) / listSize).toInt;
    item = n mod listSize;
  return res;

proc parse1Matrix*(fromString: string): Matrix[1] = 
  var splitted = fromString.split(",");
  var res: Matrix[1];
  var n = 0;
  var list = 0;
  var item = 0;
  while n<splitted.len:
    var replaced = splitted[n].replace("[","").replace("]","").replace("(","").replace(")","").replace(" ","")
    var num: int;
    discard parseInt(replaced, num, 0);
    res[list][item] = num;

    # Change list, item and n
    n = n + 1;
    list = ((n - (n mod listSize)) / listSize).toInt;
    item = n mod listSize;
  return res;