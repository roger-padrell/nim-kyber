import nim_kyber/big, nim_kyber/big/stringToList

var bk: Kyber = createRandomKyber();
var bs: KyberSender = createMessageSender(bk.publicTable, bk.publicKeys);

var m: Message = bs.sendString("Hello");

echo "Hello".stringToBinary()
echo bk.recieveString(m).stringToBinary()