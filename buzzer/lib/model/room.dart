import 'package:buzzer/model/Player.dart';

class Room {
  final String id;
  late String connectionToken;
  final Player? host;

  final int playersNumber;

  Room(this.id, this.host, this.playersNumber);

  static Room fromJson(Map<String, dynamic> json, String connectionToken) {
    Room room =
        Room(json['id'], json['host']!=null? Player.fromJson(json['host']):null, json['playersNumber']);
    room.connectionToken = connectionToken;
    return room;
  }
}
