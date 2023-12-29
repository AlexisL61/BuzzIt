import 'package:buzzer/model/Player.dart';

class Room {
  final String id;
  final Player host;

  final int playersNumber;

  Room(this.id, this.host, this.playersNumber);

  static Room fromJson(Map<String, dynamic> json) {
    return Room(
        json['id'], Player.fromJson(json['host']), json['playersNumber']);
  }
}
