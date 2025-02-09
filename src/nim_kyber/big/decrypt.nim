import consts, matrix

proc bigOrSmall*(noisedMessage: List): List = 
    var message = noisedMessage;
    var n = 0;
    let smallRange:(int,int) = ((clampingRange[0]/2).toInt, -(clampingRange[0]/2).toInt)
    while n < len(message):
        if(message[n]) in smallRange[0]..smallRange[1]:
            message[n] = 0;
        else: 
            message[n] = clampingRange[0];
        n = n + 1;
    return message;

proc decrypt*(encrypted: List, senderKeys: (List, List), signalSecret: Matrix[2]): List = 
    let term1 = senderKeys[0] * signalSecret[0];
    let term2 = senderKeys[1] * signalSecret[1];
    let noisedMessage = encrypted - term1 - term2;

    let message = bigOrSmall(noisedMessage);
    return message;