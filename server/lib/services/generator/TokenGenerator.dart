import 'dart:math';

class TokenGenerator {
  static String generateToken(){
    String token = "";
    for(int i = 0; i < 30; i++){
      int charCode = Random().nextInt(26) + 65;
      token += String.fromCharCode(charCode);
    }
    return token;
  }
}