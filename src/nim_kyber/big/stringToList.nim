import matrix, strutils, terminal, parseutils, consts

const maxStrLen = (listSize/8).toInt;

proc stringToBinary*(s: string): string =
  var res = ""
  for i in 0 ..< s.len:
    let byte = ord(s[i])
    res = res & toBin(byte, 8)
  return res;

proc stringToList*(s: string): List = 
  if len(s) > maxStrLen:
      styledEcho(fgRed, "Message strings can only be up to " & $maxStrLen & " characters")
      return
  var l: List;
  let bin = stringToBinary(s);
  var n = 0;
  if len(s) > listSize:
      styledEcho(fgRed, "Message strings can only be up to " & $maxStrLen & " characters")
      discard
      return
  while n < len(bin):
    l[n] = (int(bin[n]) - int('0')) * clampingRange[0]
    n = n + 1;
  return l;

proc binaryToChar(bin: string): char = 
  var charN: int;
  discard parseBin(bin, charN)
  return char(charN)

proc binaryToString*(input: string): string = 
  var r: string = "";
  var n = 0;
  while (n < input.len()) and (input.len()-n > 7):
    if input[n..n+7] == "00000000" or input[n..n+7] == "11111111":
      break;
    r = r & binaryToChar(input[n..n+7])
    n = n + 8;
  return r;

proc listToString*(l: List): string = 
  var str = l.join("")
  str = str.replace($clampingRange[0],"1")
  return binaryToString(str);