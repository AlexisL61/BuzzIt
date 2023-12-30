import 'package:server/model/ConnectionToken.dart';
import 'package:server/model/ReconnectionToken.dart';
import 'package:server/model/Room.dart';
import 'package:server/services/generator/RoomCodeGenerator.dart';
import 'package:server/services/generator/TokenGenerator.dart';
import 'package:server/services/router/router.dart';
import 'package:collection/collection.dart';

void startServer() {}

class BuzzerServer {
  List<Room> rooms = [];
  List<ConnectionToken> connectionTokens = [];
  List<Reconnectiontoken> reconnectionTokens = [];

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

  ConnectionToken generateConnectionToken(Room room) {
    ConnectionToken token = ConnectionToken(TokenGenerator.generateToken(), room, DateTime.now().add(Duration(minutes: 1)));
    connectionTokens.add(token);
    return token;
  }

  ConnectionToken? getConnectionToken(String token, String roomId) {
    return connectionTokens.firstWhereOrNull((element) => element.isValid(token, roomId));
  }
}
