import 'dart:math';

class RoomCodeGenerator {
  static String generate() {
    String code = "";
    for (int i = 0; i < 4; i++) {
      int charCode = Random().nextInt(26) + 65;
      code += String.fromCharCode(charCode);
    }
    return code;
  }
}