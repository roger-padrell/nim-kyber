import nim_kyber/baby

var bk: BabyKyber = createRandomBabyKyber();
var bs: BabyKyberSender = createBabyMessageSender(bk.publicTable, bk.publicKeys);

var m: BabyMessage = bs.sendMessage([0, -15, -15, 0]);

echo bk
echo bs
echo m