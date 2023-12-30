import 'dart:math';

class PlayerIdGenerator {
  static String generateId() {
    String playerId = "";
    for (int i = 0; i < 10; i++) {
      int charCode = Random().nextInt(26) + 65;
      playerId += String.fromCharCode(charCode);
    }
    return playerId;
  }
}
