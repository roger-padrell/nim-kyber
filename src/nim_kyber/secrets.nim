import std/random, matrix
randomize()

proc generateSignalSecret(rng: (int,int)): Matrix[4,4] = 
  var m: Matrix[4,4];
  var r = 0;
  var c = 0;
  while r < m.size()[0]:
    while c < m.size()[1]:
      m[r,c] = rand(rng[0]..rng[1]);
      c = c+1;
    r = r+1;
  return m;
