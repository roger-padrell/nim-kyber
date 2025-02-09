import nim_kyber/big, unittest

suite "BIG KYBER: Main tests":
    test "Baby kyber creation":
        var bk: Kyber = createRandomKyber();
        assert true;

    test "Baby message sender creation":
        var bk: Kyber = createRandomKyber();
        var bs: KyberSender = createMessageSender(bk.publicTable, bk.publicKeys);
        assert true

    test "Message encryption and decryption":
        var bk: Kyber = createRandomKyber();
        var bs: KyberSender = createMessageSender(bk.publicTable, bk.publicKeys);

        var m: Message = bs.sendString("Hello");

        var res =  bk.recieveString(m) 
        assert res == "Hello"