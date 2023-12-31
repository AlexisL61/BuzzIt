
import 'package:server/model/Player.dart';
import 'package:server/model/Room.dart';
import 'package:server/services/router/ws/WebsocketAction.dart';
import 'package:server/services/router/ws/WebsocketMessage.dart';

class RoomJoinMessage extends WebsocketConnectionMessage {
  static const String eventId = "roomJoin";
  Room? room;
  late Player player;
  late String reconnectionToken;

  @override
  List<WebsocketAction> actions = [];

  RoomJoinMessage() : super(eventId);

  @override
  void hydrateData(data) {}

  @override
  toJson() {
    if (room != null) {
      return {"event": event, "data": {
        "status": "OK",
        "room": room!.toJson(),
        "player": player.toJson(),
        "reconnectiontoken":  reconnectionToken
      }};
    }
    return {"event": event, "data": {
      "status":"NOT_FOUND",
      "message":"Room not found"
    }};
  }
}
