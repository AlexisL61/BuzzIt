
import 'package:server/services/router/ws/WebsocketAction.dart';
import 'package:server/services/router/ws/WebsocketMessage.dart';
import 'package:server/services/router/ws/messagesAction/ReconnectBuzzerToRoomAction.dart';

class RoomReconnectRequestMessage extends WebsocketConnectionMessage {
  static const String eventId = "roomReconnectRequest";

  late String roomId;
  late String reconnectionToken;
  @override
  List<WebsocketAction> actions = [ReconnectBuzzerToRoomAction()];

  RoomReconnectRequestMessage() : super(eventId);

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
