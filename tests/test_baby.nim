import nim_kyber/baby, unittest

suite "BABY KYBER: Main tests":
    test "Baby kyber creation":
        var bk: BabyKyber = createRandomBabyKyber();
        assert true;

    test "Baby message sender creation":
        var bk: BabyKyber = createRandomBabyKyber();
        var bs: BabyKyberSender = createBabyMessageSender(bk.publicTable, bk.publicKeys);
        assert true

    test "Message encryption and decryption":
        var bk: BabyKyber = createRandomBabyKyber();
        var bs: BabyKyberSender = createBabyMessageSender(bk.publicTable, bk.publicKeys);

        var m: BabyMessage = bs.sendMessage([0, -15, -15, 0]);

        assert bk.recieveMessage(m) == [0, -15, -15, 0]