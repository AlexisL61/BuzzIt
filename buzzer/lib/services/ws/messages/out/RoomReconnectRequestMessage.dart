import 'package:buzzer/services/ws/WebsocketAction.dart';
import 'package:buzzer/services/ws/WebsocketMessage.dart';

class RoomReconnectRequestMessage extends WebsocketConnectionMessage {
  late String roomId;
  late String reconnectionToken;
  @override
  List<WebsocketAction> actions = [];

  RoomReconnectRequestMessage() : super("roomReconnectRequest");

  @override
  void hydrateData(data) {
    this.roomId = data["roomId"];
    this.reconnectionToken = data["token"];
  }

  @override
  toJson() {
    return {
      "event": event,
      "data": {"roomId": roomId, "token": reconnectionToken}
    };
  }
}
