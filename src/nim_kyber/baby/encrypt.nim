import matrix, std/random

proc generateSenderSignalSecret*(rng: (int,int)= (-1,1)): Matrix[2] = 
  var m: Matrix[2];
  var r = 0;
  var c = 0;
  while r < 2:
    while c < 4:
      m[r,c] = rand(rng[0]..rng[1]);
      c = c+1;
    r = r+1;
  return m;

proc generateSenderNoiseSecret*(rng: (int,int)= (-1,1)): Matrix[2] = 
  var m: Matrix[2];
  var r = 0;
  var c = 0;
  while r < 2:
    while c < 4:
      m[r,c] = rand(rng[0]..rng[1]);
      c = c+1;
    r = r+1;
  return m;

proc generateSenderEncryptionKey*(table: Matrix[4], signal_secret: Matrix[2], noise_secret: Matrix[2]): (List, List) =
  ## Generates the public key pair using the given table, signal secret, and noise secret.
  let term1 = table[0] * signal_secret[0]
  let term2 = table[2] * signal_secret[1]
  let sumTerms1 = term1 + term2
  let public1 = sumTerms1 + noise_secret[0]
  
  let term3 = table[1] * signal_secret[0]
  let term4 = table[3] * signal_secret[1]
  let sumTerms2 = term3 + term4
  let public2 = sumTerms2 + noise_secret[1]
  
  return (public1, public2)

proc encryptMessage*(message: List, signalSecret: Matrix[2], reciverPublicKey: (List,List)): List = 
    let term1 = signalSecret[0] * reciverPublicKey[0];
    let term2 = signalSecret[1] * reciverPublicKey[1];
    let sumTerms1 = term1 + term2;
    let encrypted = sumTerms1 + message;
    return encrypted