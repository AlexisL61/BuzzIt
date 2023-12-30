import 'package:buzzer/model/InGame/ActivePlayer.dart';
import 'package:buzzer/model/InGame/InGameRoom.dart';
import 'package:buzzer/services/ws/WebsocketAction.dart';
import 'package:buzzer/services/ws/WebsocketMessage.dart';

class RoomJoinMessage extends WebsocketConnectionMessage {
  static const String eventId = "roomJoin";

  late Map<String, dynamic> inGameRoomData;
  @override
  List<WebsocketAction> actions = [];

  RoomJoinMessage() : super(eventId);

  @override
  void hydrateData(data) {
    this.inGameRoomData = data["room"];
  }

  InGameRoom getInGameRoomWithActivePlayer(ActivePlayer activePlayer){
    return InGameRoom.fromJson(inGameRoomData, activePlayer);
  }

  @override
  toJson() {
    return {
      "event": event,
      "data": {"room": inGameRoomData}
    };
  }
}
