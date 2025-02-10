# Big Kyber 
## Table of contents
- [Introduction](#introduction)
- [Creating kyber object](#creating-kyber-object)
- [Creating sending object](#creating-sending-object)
- [Encrypting and sending messages](#encrypting-and-sending-messages)
- [Decrypting messages](#decrypting-messages)
- [Encrypting and sending strings]()
- [Decrypting strings]()

## Introduction
Big kyber is the full version of kyber. It uses big numbers for more secure encryption. We recommend trying [baby kyber](baby.md) for learning the usage.

## Creating kyber object
The kyber object is the one that creates the public keys, and the one that will recive the message. It's in **machine A**.

### Creating a random kyber object
To create a random kyber object, you just need to use `createRandomBabyKyber` function:
```nim
# Code origin: nim_kyber/docs/big.md
# Example: Creating a random-kyber object
# Machine: A (reciever)

import nim_kyber # Import-kyber

# Create random baby-kyber object
var bk: Kyber = createRandomKyber();
```

### Creating kyber object with known tables and keys
You can also create an object with predefined tables and keys.
It is the same as in [baby kyber](), but I can't show the code here because a Kyber object is bery big.

## Creating sending object
To create the object to encrypt messages from a sepecific kyber (or baby-kyber), you need it's public table and it's public keys. The sender is **machine B**.

```nim
# Code origin: nim_kyber/docs/baby.md
# Example: Creating sending object
# Machine: B (sender)

import nim_kyber/baby # Import baby-kyber

# Define known public table and keys
let publicTable = [
    [13, 13, -12, 3],
    [-8, 6, -9, 8],
    [-1, 10, -5, -8],
    [0, -7, -14, 7]
] # A's bk.publicTable
let publicKeys = ([-13, 4, -13, -14], [6, -13, -2, -11]); # A's bk.publicKeys

# Create Baby-Kyber Message Sender object
var bms: BabyKyberSender = createBabyMessageSender(publicTable, publicKeys);
```

## Encrypting and sending messages
In baby-kyber you can only send 4-numbered lists containing exclusively 0 and -15. You do this in **machine B**. The following code sends a message, but it needs you to add the code in [the previous example](#creating-sending-object) to work.
```nim
# Code origin: nim_kyber/docs/baby.md
# Example: Encrypting and sending messages
# Machine: B (sender)

import nim_kyber/baby # Import baby-kyber

# Baby-Kyber message sender already created (bms)
# Encrypt and send message
var m: BabyMessage = bs.sendMessage([0, -15, -15, 0]); # The sended messace is [0, -15, -15, 0]

# Now, send "m" to the other machine (A) to decrypt the message from there. 
# "m" contains two objects: the encrypted message, and the public keys of the sender.
```

## Decrypting messages
For decripting a message, you need to know the encrypted message as well as the public keys of the sender. You do this in **machine A**.
The following code decrypts a message, but it needs you to add the code in [the previous A example](#creating-kyber-object) to work. Keep in mind that when creating a kyber object, it uses random numbers, so you can't expect to decrypt a message from an older program run if you have ended it (or if the sender uses the public data from another run).
```nim
# Code origin: nim_kyber/docs/baby.md
# Example: Decrypting messages
# Machine: A (reciever)

import nim_kyber/baby # Import baby-kyber

# Baby-kyber object creation (bk)

# Define the known encrypted message
var m: BabyMessage = BabyMessage(encryptedMessage: [4,-13,6,-7], senderPublicKeys: ([-6,10,-8,6], [7,-14,-9,-15])) # B's "m"

# Decrypt the message
var decrypted = bk.recieveMessage(m) # [0, -15, -15, 0]
```

## Practice
Well done, you've finished learning with this tutorial!
To practice a little bit, I recommend you to do these practice exercises:

### Practice 1
Write the respecting code in machines A and B, to create a random baby-kyber instance and send it the message `[-15,0,-15,0]`.
Then check if it worked.

### Practice 2
With the following data, decrypt the message:

Reciever:
- signalSecret: `[[-1, -1, 0, -1], [1, 1, -1, 1]]`
- publicTable: `[[-6, 14, -9, 5], [15, -7, -5, -2], [13, 14, 0, -4], [7, 9, 0, 12]]`
- noiseSecret: `[[0, -1, 0, 1], [-1, -1, 0, 1]]`
- publicKeys: `([13, -7, 6, -5], [13, 0, 3, 2])`

Message:
- encryptedMessage: `[-4, -13, -4, 15]`
- senderPublicKeys: `([12, -3, -14, -1], [-1, -10, 4, 2])`

*Hint: use the [predefined object creation](#creating-kyber-object-with-known-tables-and-keys)*
