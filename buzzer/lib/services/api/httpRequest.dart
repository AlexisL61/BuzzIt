import 'package:buzzer/model/Player.dart';
import 'package:buzzer/model/room.dart';

class ApiService {
  static Future<Room> getRoomData(String roomId) async{
    await Future.delayed(Duration(seconds: 1));
    return Room(roomId, Player(
      "Alexis",
      "https://avatars.githubusercontent.com/u/30233189?v=4"
    ), 2);
  }
}