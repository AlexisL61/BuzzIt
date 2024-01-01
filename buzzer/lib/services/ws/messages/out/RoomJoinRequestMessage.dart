import 'package:buzzer/services/ws/WebsocketAction.dart';
import 'package:buzzer/services/ws/WebsocketMessage.dart';

class RoomJoinRequestMessage extends WebsocketConnectionMessage {
  late String roomId;
  late String token;
  @override
  List<WebsocketAction> actions = [];

  RoomJoinRequestMessage() : super("roomJoinRequest");

  @override
  void hydrateData(data) {
    roomId = data["roomId"];
    token = data["token"];
  }

  @override
  toJson() {
    return {
      "event": event,
      "data": {"roomId": roomId, "token": token}
    };
  }
}
