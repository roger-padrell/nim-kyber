import std/random, matrix
randomize()

proc generateSignalSecret(rng: (int,int)= (-1,1)): Matrix[2,4] = 
  var m: Matrix[2,4];
  m = m.fill(0)
  var r = 0;
  var c = 0;
  while r < m.size()[0]:
    while c < m.size()[1]:
      m[r,c] = rand(rng[0]..rng[1]);
      c = c+1;
    r = r+1;
  return m;
