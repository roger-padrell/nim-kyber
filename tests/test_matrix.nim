import nim_kyber/matrix, unittest

suite "Matrix tests":
  test "Matrix creation":
    var m: Matrix[2,2];
    assert m.size() == (2,2)

  test "Matrix is equal":
    var m: Matrix[2,2] = [[1,1],[1,1]]
    var n: Matrix[2,2] = [[1,1],[1,1]]
    var o: Matrix[2,2] = [[2,1],[1,1]]
    assert m == n
    assert m != o

  test "Matrix addition":
    var m: Matrix[2,2] = [[1,1],[1,1]]
    var n: Matrix[2,2] = [[2,2],[2,2]]
    var o: Matrix[2,2] = [[3,3],[3,3]]
    var p = m+n;
    assert o == p

  test "Matrix subtraction":
    var m: Matrix[2,2] = [[3,3],[3,3]]
    var n: Matrix[2,2] = [[1,1],[1,1]]
    var o: Matrix[2,2] = [[2,2],[2,2]]
    var p = m-n;
    assert o == p