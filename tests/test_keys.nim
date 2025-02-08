import unittest, nim_kyber/[keys]

suite "Key generation test":
    test "Generate signal secret":
        var ss = generateSignalSecret()
        assert ss.len() == 2
        assert ss[0].len() == 4

    test "Generate noise secret":
        var ns = generateNoiseSecret()
        assert ns.len() == 2
        assert ns[0].len() == 4

    test "Generate public table":
        var pt = generatePublicTable()
        assert pt.len() == 4
        assert pt[0].len() == 4

    test "Get public keys from signal-secret, noise-secret and public-table":
        let table = [
            [13, 13, -12, 3],   # Row 0 (correct)
            [-8, 6, -9, 8],     # Row 1 (previously Row 2 in your input)
            [-1, 10, -5, -8],   # Row 2 (previously Row 1 in your input)
            [0, -7, -14, 7]     # Row 3 (correct)
        ]

        let signal_secret = [
            [0, 0, 1, 0],
            [0, 1, 1, -1]
            ]

        let noise_secret = [
        [-1, 1, -1, -1],
        [1, 0, -1, 1]
        ]

        let (public1, public2) = generatePublicKey(table, signal_secret, noise_secret)
        assert public1  == [-13, 4, -13, -14]
        assert public2  == [6, -13, -2, -10]