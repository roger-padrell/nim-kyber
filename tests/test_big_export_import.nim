import unittest, nim_kyber/big

suite "BIG KYBER: Exporting and importing test":
    test "Full kyber":
        var k: Kyber = createRandomKyber();
        var str: string = k.exportFullKyber();
        var ok: Kyber = importFullKyber(str);

        assert k.publicTable == ok.publicTable;
        assert k.publicKeys == ok.publicKeys;
        assert k.signalSecret == ok.signalSecret;
        assert k.noiseSecret == ok.noiseSecret;

    test "Public kyber":
        var k: Kyber = createRandomKyber();
        var str: string = k.public().toString();
        var ok: PublicKyber = importPublicKyber(str);

        assert k.publicTable == ok.publicTable;
        assert k.publicKeys == ok.publicKeys;

    test "Message":
        var k: Kyber = createRandomKyber();
        var ms: KyberSender = createMessageSender(k.publicTable, k.publicKeys);
        var m = ms.sendString("Hello");
        var str: string = m.exportMessage();
        var im: Message = importMessage(str);

        assert m.encryptedMessage == im.encryptedMessage;
        assert m.senderPublicKeys == im.senderPublicKeys;