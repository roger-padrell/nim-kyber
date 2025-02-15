import big/encrypt, big/decrypt, big/keys, big/matrix, big/stringToList, big/consts, tables, json

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


    PublicKyber* = object
        publicTable*: Matrix[4]
        publicKeys*: (List,List)
proc createKyberFrom*(publicTable: Matrix[4], signalSecret: Matrix[2], noiseSecret: Matrix[2]): Kyber =
    var k: Kyber;
    k.noiseSecret = noiseSecret;
    k.signalSecret = signalSecret;
    k.publicTable = publicTable;
    k.publicKeys = generatePublicKey(publicTable, signalSecret, noiseSecret);
    return k;

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

# Exporting
proc public*(k: Kyber): PublicKyber = 
    var p: PublicKyber;
    p.publicKeys = k.publicKeys;
    p.publicTable = k.publicTable;
    return p;

proc toString*(p: PublicKyber): string = 
    var t: Table[string,string];
    t["publicTable"] = $p.publicTable;
    t["publicKeys"] = $p.publicKeys;
    return $t;

proc exportFullKyber*(k: Kyber): string = 
    var t: Table[string,string];
    t["publicTable"] = $k.publicTable;
    t["publicKeys"] = $k.publicKeys;
    t["noiseSecret"] = $k.noiseSecret;
    t["signalSecret"] = $k.signalSecret;
    return $t;

proc exportMessage*(m: Message): string = 
    var t: Table[string,string];
    t["encryptedMessage"] = $m.encryptedMessage;
    t["senderPublicKeys"] = $m.senderPublicKeys;
    return $t;

# Importing
proc importPublicKyber*(s: string): PublicKyber = 
    var js = parseJson(s);
    var pk: PublicKyber;
    pk.publicTable = parse4Matrix(js["publicTable"].getStr());
    var pKeys: Matrix[2] = parse2Matrix(js["publicKeys"].getStr())
    pk.publicKeys = (pKeys[0],pKeys[1])
    return pk;

proc importFullKyber*(s: string): Kyber = 
    var js = parseJson(s);
    var pk: Kyber;
    pk.publicTable = parse4Matrix(js["publicTable"].getStr());
    var pKeys: Matrix[2] = parse2Matrix(js["publicKeys"].getStr())
    pk.publicKeys = (pKeys[0],pKeys[1])
    pk.noiseSecret = parse2Matrix(js["noiseSecret"].getStr());
    pk.signalSecret = parse2Matrix(js["signalSecret"].getStr());
    return pk;

proc importMessage*(s: string): Message = 
    var js = parseJson(s);
    var pk: Message;
    pk.encryptedMessage = parse1Matrix(js["encryptedMessage"].getStr())[0];
    var pKeys: Matrix[2] = parse2Matrix(js["senderPublicKeys"].getStr())
    pk.senderPublicKeys = (pKeys[0],pKeys[1])
    return pk;

export encrypt, decrypt, keys, matrix, consts