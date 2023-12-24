
import 'package:buzzer/services/ws/WebsocketAction.dart';
import 'package:buzzer/services/ws/WebsocketMessage.dart';

class RoomChosenMessage extends WebsocketConnectionMessage {  
  late String roomId;
  @override
  List<WebsocketAction> actions = [];

  RoomChosenMessage() : super("roomChosen");
  
  @override
  void hydrateData(data) {
    this.roomId = data["roomId"];
  }

  @override
  toJson() {
    return {
      "event": event,
      "data": {
        "roomId": roomId
      }
    };
  }
}
