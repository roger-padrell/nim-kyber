import nim_kyber/matrix, nim_kyber/clock, unittest

suite "Clock single tests":
    # Clock single
    test "Clock single int - no clock needed":
        var a = 5
        a = a.clock((-10,10),1)
        assert a == 5;

    test "Clock single int - positive clock needed":
        var a = -15
        a = a.clock((-10,10),1)
        assert a == -10;

    test "Clock single int - negative clock needed":
        var a = 15
        a = a.clock((-10,10),1)
        assert a == 10;

suite "Clock matrix tests":
    test "Clock matrix int - no clock needed":
        var a: Matrix[2,2] = [[5,4],[7,-5]]
        a = a.clock((-10,10),1)
        assert a == [[5,4],[7,-5]];

    test "Clock matrix int - positive clock needed":
        var a: Matrix[2,2] = [[-12,4],[7,-25]]
        a = a.clock((-10,10),1)
        assert a == [[-10,4],[7,-10]];

    test "Clock matrix int - negative clock needed":
        var a: Matrix[2,2] = [[12,4],[7,25]]
        a = a.clock((-10,10),1)
        assert a == [[10,4],[7,10]];