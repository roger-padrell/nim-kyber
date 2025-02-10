# Big Kyber 
## Table of contents
- [Introduction](#introduction)
- [Creating kyber object](#creating-kyber-object)
- [Creating sending object](#creating-sending-object)
- [Encrypting and sending strings]()
- [Decrypting strings]()

## Introduction
Big kyber is the full version of kyber. It uses big numbers for more secure encryption. We recommend trying [baby kyber](baby.md) for learning the usage.

## Creating kyber object
The kyber object is the one that creates the public keys, and the one that will recive the message. It's in **machine A**.

### Creating a random kyber object
To create a random kyber object, you just need to use `createRandomKyber` function:
```nim
# Code origin: nim_kyber/docs/big.md
# Example: Creating a random-kyber object
# Machine: A (reciever)

import nim_kyber # Import-kyber

# Create random kyber object
var bk: Kyber = createRandomKyber();
```

### Creating kyber object with known tables and keys
You can also create an object with predefined tables and keys.
It is the same as in [baby kyber](), but I can't show the code here because a Kyber object is bery big.

## Creating sending object
To create the object to encrypt messages from a sepecific kyber (or baby-kyber), you need it's public table and it's public keys. The sender is **machine B**.

```nim
# Code origin: nim_kyber/docs/big.md
# Example: Creating sending object
# Machine: B (sender)

import nim_kyber # Import-kyber

# Define known public table and keys
let publicTable = [
    [13, 13, -12, 3],
    [-8, 6, -9, 8],
    [-1, 10, -5, -8],
    [0, -7, -14, 7]
] # A's bk.publicTable
let publicKeys = ([-13, 4, -13, -14], [6, -13, -2, -11]); # A's bk.publicKeys

# Create Kyber Message Sender object
var bms: KyberSender = createMessageSender(publicTable, publicKeys);
```

## Encrypting and sending messages
For creating and sending messages, you can do the same like in [baby-kyber](baby.md), but removing "Baby" from the words "BabyKyber", "BabyMessage", and using x-numbered lists.

## Encrypting and sending strings
Strings sending is more used in kyber (big kyber), as big kyber gives more sended bits to work with.

## Decrypting strings
