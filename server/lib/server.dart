import 'package:server/model/room.dart';
import 'package:server/services/ws/router.dart';

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
}
