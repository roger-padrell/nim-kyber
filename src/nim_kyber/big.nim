import big/encrypt, big/decrypt, big/keys, big/matrix, big/stringToList, big/consts, json, std/jsonutils, tables

type 
    Kyber* = object
        signalSecret*: Matrix[2]
        publicTable*: Matrix[4]
        noiseSecret*: Matrix[2]
        publicKeys*: (List, List)

    Message* = object
        encryptedMessage*: List
        senderPublicKeys*: (List, List)
    
    KyberSender* = object
        signalSecret*: Matrix[2]
        publicTable*: Matrix[4]
        noiseSecret*: Matrix[2]
        reciverPublicKeys*: (List, List)
        senderPublicKeys*: (List, List)

proc createRandomKyber*(): Kyber = 
    var k: Kyber;
    k.noiseSecret = generateNoiseSecret();
    k.signalSecret = generateSignalSecret();
    k.publicTable = generatePublicTable();
    k.publicKeys = generatePublicKey(k.publicTable, k.signalSecret, k.noiseSecret);
    return k;

proc createMessageSender*(publicTable: Matrix[4], reciverPublicKeys: (List, List)): KyberSender =
    var k: KyberSender;
    k.publicTable = publicTable;
    k.reciverPublicKeys = reciverPublicKeys;
    k.noiseSecret = generateSenderNoiseSecret();
    k.signalSecret = generateSenderSignalSecret();
    k.senderPublicKeys = generateSenderEncryptionKey(k.publicTable, k.signalSecret, k.noiseSecret)
    return k;

proc sendMessage*(k: KyberSender, message: List): Message = 
    var m: Message;
    m.encryptedMessage = encryptMessage(message, k.signalSecret, k.reciverPublicKeys);
    m.senderPublicKeys = k.senderPublicKeys;
    return m;

proc sendString*(k: KyberSender, mess: string): Message = 
    var m: Message;
    var message: List = stringToList(mess)
    if message == message.fill(0):
        return;
    m.encryptedMessage = encryptMessage(message, k.signalSecret, k.reciverPublicKeys);
    m.senderPublicKeys = k.senderPublicKeys;
    return m;

proc recieveMessage*(k: Kyber, m: Message): List = 
    return decrypt(m.encryptedMessage, m.senderPublicKeys, k.signalSecret)

proc recieveString*(k: Kyber, m: Message): string = 
    let m = recieveMessage(k, m)
    return listToString(m);

export encrypt, decrypt, keys, matrix, consts