import 'package:server/model/room.dart';
import 'package:server/services/generator/RoomCodeGenerator.dart';
import 'package:server/services/ws/router.dart';
import 'package:collection/collection.dart';

void startServer() {}

class Server {
  List<Room> rooms = [];

  factory Server() {
    return _singleton;
  }

  static final Server _singleton = Server._internal();

  Server._internal(){
    WsRouter wsRouter = WsRouter();
    wsRouter.startRouter();
  }

  Room getRoomById(String id) {
    return rooms.firstWhere((room) => room.id == id, orElse: (){
      Room room = Room(id);
      rooms.add(room);
      return room;
    });
  }

  Room getRandomRoom(){
    bool found = false;
    String roomCode = "";
    while(!found){
      roomCode = RoomCodeGenerator.generate();
      if(rooms.firstWhereOrNull((room) => room.id == roomCode) == null){
        found = true;
      }
    }
    Room room = Room(roomCode);
    rooms.add(room);
    return room;
  }
}
