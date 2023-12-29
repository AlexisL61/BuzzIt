import 'package:server/services/router/ws/WebsocketAction.dart';
import 'package:server/services/router/ws/WebsocketMessage.dart';
import 'package:server/services/router/ws/messagesAction/AddBuzzerToRoomAction.dart';

class RoomJoinRequestMessage extends WebsocketConnectionMessage {
  static const String eventId = "roomJoinRequest";
  late String roomId;
  @override
  List<WebsocketAction> actions = [AddBuzzerToRoomAction()];

  RoomJoinRequestMessage() : super(eventId);

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
