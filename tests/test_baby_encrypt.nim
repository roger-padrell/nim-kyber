import unittest, nim_kyber/baby/[encrypt]

suite "BABY KYBER: Encryption tests":
    test "Encrypting key generation":
        let table = [
            [13, 13, -12, 3],   # Row 0 (correct)
            [-8, 6, -9, 8],     # Row 1 (previously Row 2 in your input)
            [-1, 10, -5, -8],   # Row 2 (previously Row 1 in your input)
            [0, -7, -14, 7]     # Row 3 (correct)
        ]

        let signal_secret = [
            [0, 1, -1, 0],
            [0, 0, 0, -1]
            ]

        let noise_secret = [
        [-1, -1, 0, -1],
        [0, 0, 1, 0]
        ]

        let (public1, public2) = generateSenderEncryptionKey(table, signal_secret, noise_secret)
        assert public1  == [-6, 10, -8, 6]
        assert public2  == [7, -14, -9, -15]

    test "Message encryption":
        let message = [-15,-15,0,-15];
        let signal_secret = [
            [0, 1, -1, 0],
            [0, 0, 0, -1]
            ]
        let recieverPublicKey = ([-13, 4, -13, -14], [6, -13, -2, -11])

        let encrypted = encryptMessage(message, signal_secret, recieverPublicKey)

        assert encrypted == [4, -13, 6, -7]