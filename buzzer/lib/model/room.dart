import 'package:buzzer/model/Player.dart';

class Room {
  final String id;
  final Player host;

  final int playersNumber;

  Room(this.id, this.host, this.playersNumber);
}
