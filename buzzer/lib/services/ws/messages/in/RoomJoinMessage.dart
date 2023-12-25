import 'package:buzzer/services/ws/WebsocketAction.dart';
import 'package:buzzer/services/ws/WebsocketMessage.dart';

class RoomJoinMessage extends WebsocketConnectionMessage {
  late String roomId;
  late bool success;
  @override
  List<WebsocketAction> actions = [];

  RoomJoinMessage() : super("roomJoin");

  @override
  void hydrateData(data) {
    this.roomId = data["roomId"];
    this.success = data["success"];
  }

  @override
  toJson() {
    return {
      "event": event,
      "data": {"roomId": roomId, "success": success}
    };
  }
}
