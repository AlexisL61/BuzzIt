import 'package:server/model/ConnectionToken.dart';
import 'package:server/model/Room.dart';
import 'package:server/services/generator/RoomCodeGenerator.dart';
import 'package:server/services/router/router.dart';
import 'package:collection/collection.dart';

void startServer() {}

class BuzzerServer {
  List<Room> rooms = [];
  List<ConnectionToken> connectionTokens = [];

  factory BuzzerServer() {
    return _singleton;
  }

  static final BuzzerServer _singleton = BuzzerServer._internal();

  BuzzerServer._internal() {
    ServerRouter wsRouter = ServerRouter();
    wsRouter.startRouter();
  }

  Room? getRoomById(String id) {
    return rooms.firstWhereOrNull((room) => room.id == id);
  }

  Room getRandomRoom() {
    bool found = false;
    String roomCode = "";
    while (!found) {
      roomCode = RoomCodeGenerator.generate();
      if (rooms.firstWhereOrNull((room) => room.id == roomCode) == null) {
        found = true;
      }
    }
    Room room = Room(roomCode);
    rooms.add(room);
    return room;
  }
}
