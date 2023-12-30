import 'package:server/model/Room.dart';

class ConnectionToken {
  String token;
  Room room;
  DateTime timeout;

  ConnectionToken(this.token, this.room, this.timeout);

  bool isValid(String token, String roomId) {
    return this.token == token && this.room.id == roomId && timeout.isAfter(DateTime.now());
  }
}
