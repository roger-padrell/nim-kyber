import nim_kyber/matrix, unittest

suite "4-number list tests":
  test "Creation":
    let
      a = [-3, 0, 14, 14]
    assert a == [-3, 0, 14, 14]

  test "Addition":
    let 
      a = [-3, 0, 14, 14]
      b = [-14, 4, 8, -2]
      p = a + b
    assert p == [14, 4, -9, 12]

  test "Subtraction":
    let 
      a = [-3, 0, 14, 14]
      b = [-14, 4, 8, -2]
      p = a - b
    assert p == [11, -4, 6, -15]

  test "Multiplication":
    let 
      a = [-3, 0, 14, 14]
      b = [-14, 4, 8, -2]
      p = a * b
    assert p == [-2, -3, -6, -10]