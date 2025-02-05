import std/random, matrix
randomize()

proc generateSignalSecret*(rng: (int,int)= (-1,1)): Matrix[2] = 
  var m: Matrix[2];
  var r = 0;
  var c = 0;
  while r < 2:
    while c < 4:
      m[r,c] = rand(rng[0]..rng[1]);
      c = c+1;
    r = r+1;
  return m;

proc generateNoiseSecret*(rng: (int,int)= (-1,1)): Matrix[2] = 
  var m: Matrix[2];
  var r = 0;
  var c = 0;
  while r < 2:
    while c < 4:
      m[r,c] = rand(rng[0]..rng[1]);
      c = c+1;
    r = r+1;
  return m;

proc generatePublicTable*(rng: (int,int)= (-15,15)): Matrix[4] = 
  var m: Matrix[4];
  var r = 0;
  var c = 0;
  while r < 2:
    while c < 4:
      m[r,c] = rand(rng[0]..rng[1]);
      c = c+1;
    r = r+1;
  return m;

proc clamp(x: int): int =
  ## Clamps a value to the range [-15, 15] using modulo 31 arithmetic.
  let m = x mod 31
  if m > 15:
    return m - 31
  elif m < -15:
    return m + 31
  else:
    return m

proc rotateRight(arr: array[4, int], n: int): array[4, int] =
  ## Rotates an array to the right by `n` positions, with sign changes for wrapped elements.
  let n = n mod 4
  if n == 0:
    return arr
  var res: array[4, int]
  for i in 0..<4:
    let newPos = (i + n) mod 4
    res[newPos] = arr[i]
    if newPos < n:
      res[newPos] = -res[newPos]  # Change sign for wrapped elements
  return res

proc multiply(a, b: array[4, int]): array[4, int] =
  ## Multiplies two 4-element arrays using the specified rules.
  var sum: array[4, int] = [0, 0, 0, 0]
  for i in 0..3:
    var term: array[4, int]
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

proc addLists(a, b: array[4, int]): array[4, int] =
  ## Adds two 4-element arrays and clamps the result.
  for i in 0..3:
    result[i] = clamp(a[i] + b[i])

proc generatePublicKey*(table: array[4, array[4, int]], signal_secret: array[2, array[4, int]], noise_secret: array[2, array[4, int]]): (array[4, int], array[4, int]) =
  ## Generates the public key pair using the given table, signal secret, and noise secret.
  let term1 = multiply(table[0], signal_secret[0])
  let term2 = multiply(table[1], signal_secret[1])
  let sumTerms1 = addLists(term1, term2)
  let public1 = addLists(sumTerms1, noise_secret[0])
  
  let term3 = multiply(table[2], signal_secret[0])
  let term4 = multiply(table[3], signal_secret[1])
  let sumTerms2 = addLists(term3, term4)
  let public2 = addLists(sumTerms2, noise_secret[1])
  
  return (public1, public2)