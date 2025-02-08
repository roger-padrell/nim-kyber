import unittest, nim_kyber/[decrypt]

suite "Decryption tests":
    test "Big or small":
        assert bigOrSmall([-2,13,7,-11], (-7, 7)) == [0, -15, 0, -15]
        assert bigOrSmall([7,-7,7,-7], (-7, 7)) == [0,0,0,0]
        assert bigOrSmall([8, -8, 8, -8], (-7, 7)) == [-15, -15, -15, -15]

    test "Message encryption":
        let encrypted = [4, -13, 6, -7];
        let signal_secret = [
            [0,0,1,0],
            [0,1,1,-1]
            ]
        let senderKeys = ([-6, 10, -8, 6],[7, -14, -9, -15])

        let decrypted = decrypt(encrypted, senderKeys, signal_secret)

        assert decrypted == [-15, -15, 0, -15]