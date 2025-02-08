import baby/encrypt, baby/decrypt, baby/keys, baby/matrix

type 
    BabyKyber* = object
        signalSecret*: Matrix[2]
        publicTable*: Matrix[4]
        noiseSecret*: Matrix[2]
        publicKeys*: (List, List)

    BabyMessage* = object
        encryptedMessage*: List
        senderPublicKeys*: (List, List)
    
    BabyKyberSender* = object
        signalSecret*: Matrix[2]
        publicTable*: Matrix[4]
        noiseSecret*: Matrix[2]
        reciverPublicKeys*: (List, List)
        senderPublicKeys*: (List, List)

proc createRandomBabyKyber*(): BabyKyber = 
    var bk: BabyKyber;
    bk.noiseSecret = generateNoiseSecret();
    bk.signalSecret = generateSignalSecret();
    bk.publicTable = generatePublicTable();
    bk.publicKeys = generatePublicKey(bk.publicTable, bk.signalSecret, bk.noiseSecret);
    return bk;

proc createBabyMessageSender*(publicTable: Matrix[4], reciverPublicKeys: (List, List)): BabyKyberSender =
    var bk: BabyKyberSender;
    bk.publicTable = publicTable;
    bk.reciverPublicKeys = reciverPublicKeys;
    bk.noiseSecret = generateSenderNoiseSecret();
    bk.signalSecret = generateSenderSignalSecret();
    bk.senderPublicKeys = generateSenderEncryptionKey(bk.publicTable, bk.signalSecret, bk.noiseSecret)
    return bk;

proc sendMessage*(bk: BabyKyberSender, message: List): BabyMessage = 
    var bm: BabyMessage;
    bm.encryptedMessage = encryptMessage(message, bk.signalSecret, bk.reciverPublicKeys);
    bm.senderPublicKeys = bk.senderPublicKeys;
    return bm;

proc recieveMessage*(bk: BabyKyber, bm: BabyMessage): List = 
    return decrypt(bm.encryptedMessage, bm.senderPublicKeys, bk.signalSecret)

export encrypt, decrypt, keys, matrix