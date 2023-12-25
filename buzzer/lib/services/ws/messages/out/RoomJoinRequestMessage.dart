import 'package:buzzer/services/ws/WebsocketAction.dart';
import 'package:buzzer/services/ws/WebsocketMessage.dart';

class RoomJoinRequestMessage extends WebsocketConnectionMessage {
  late String roomId;
  @override
  List<WebsocketAction> actions = [];

  RoomJoinRequestMessage() : super("roomJoinRequest");

  @override
  void hydrateData(data) {
    this.roomId = data["roomId"];
  }

  @override
  toJson() {
    return {
      "event": event,
      "data": {"roomId": roomId}
    };
  }
}
