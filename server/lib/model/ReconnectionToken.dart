import 'package:server/model/Player.dart';
import 'package:server/server.dart';

class Reconnectiontoken {
  String token;
  String roomId;
  Player player;
  DateTime timeout;

  Reconnectiontoken(this.token, this.roomId, this.player, this.timeout);

  bool isValid(String token, String roomId) {
    return this.token == token &&
        this.roomId == roomId &&
        timeout.isAfter(DateTime.now())
        && BuzzerServer().getRoomById(roomId) != null;
  }
}
