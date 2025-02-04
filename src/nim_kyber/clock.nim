import matrix

proc clock*(num: int, rng: (int,int), by: int): int =
    var n: int = num;
    while n > rng[1] or n < rng[0]:
        if n > rng[1]:
            n = n - by;
        elif n < rng[0]:
            n = n + by;
    return n;

proc clock*(mat: Matrix, rng: (int,int), by: int): Matrix =
    var m: Matrix = mat;
    var r = 0;
    var c = 0;
    while r < m.size()[0]:
        while c < m.size()[1]:
            m[r,c] = m[r,c].clock(rng, by);
            c = c+1;
        r = r+1;
    return m;