import 'package:server/services/ws/WebsocketAction.dart';
import 'package:server/services/ws/WebsocketMessage.dart';
import 'package:server/services/ws/messagesAction/AddBuzzerToRoomAction.dart';

class RoomChosenMessage extends WebsocketConnectionMessage {
  static const String eventId = "roomChosen";
  late String roomId;
  @override
  List<WebsocketAction> actions = [AddBuzzerToRoomAction()];

  RoomChosenMessage() : super(eventId);

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
