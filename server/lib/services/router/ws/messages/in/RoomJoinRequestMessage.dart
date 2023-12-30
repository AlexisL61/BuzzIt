import 'package:server/services/router/ws/WebsocketAction.dart';
import 'package:server/services/router/ws/WebsocketMessage.dart';
import 'package:server/services/router/ws/messagesAction/AddBuzzerToRoomAction.dart';

class RoomJoinRequestMessage extends WebsocketConnectionMessage {
  static const String eventId = "roomJoinRequest";
  late String roomId;
  late String token;
  @override
  List<WebsocketAction> actions = [AddBuzzerToRoomAction()];

  RoomJoinRequestMessage() : super(eventId);

  @override
  void hydrateData(data) {
    this.roomId = data["roomId"];
    this.token = data["token"];
  }

  @override
  toJson() {
    return {
      "event": event,
      "data": {"roomId": roomId, "token": token}
    };
  }
}
