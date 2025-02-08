import matrix

proc bigOrSmall*(noisedMessage: List, smallRange:(int,int)=(-7,7)): List = 
    var message = noisedMessage;
    var n = 0;
    while n < len(message):
        if(message[n]) in smallRange[0]..smallRange[1]:
            message[n] = 0;
        else: 
            message[n] = -15;
        n = n + 1;

    return message;

proc decrypt*(encrypted: List, senderKeys: (List, List), signalSecret: Matrix[2]): List = 
    let term1 = senderKeys[0] * signalSecret[0];
    let term2 = senderKeys[1] * signalSecret[1];
    let termSum = term1 + term2;
    let noisedMessage = encrypted - termSum;

    let message = bigOrSmall(noisedMessage, (-7,7));
    return message;