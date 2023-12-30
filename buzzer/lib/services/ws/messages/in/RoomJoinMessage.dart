import 'package:buzzer/model/InGame/ActivePlayer.dart';
import 'package:buzzer/model/InGame/InGamePlayer.dart';
import 'package:buzzer/model/InGame/InGameRoom.dart';
import 'package:buzzer/services/ws/WebsocketAction.dart';
import 'package:buzzer/services/ws/WebsocketMessage.dart';

class RoomJoinMessage extends WebsocketConnectionMessage {
  static const String eventId = "roomJoin";

  late Map<String, dynamic> inGameRoomData;
  late InGamePlayer player;
  @override
  List<WebsocketAction> actions = [];

  RoomJoinMessage() : super(eventId);

  @override
  void hydrateData(data) {
    this.inGameRoomData = data["room"];
    this.player = InGamePlayer.fromJson(data["player"]);
  }

  InGameRoom getInGameRoomWithActivePlayer(ActivePlayer activePlayer) {
    InGameRoom roomCreated = InGameRoom.fromJson(inGameRoomData, activePlayer);
    activePlayer.id = player.id;
    return roomCreated;
  }

  @override
  toJson() {
    return {
      "event": event,
      "data": {"room": inGameRoomData}
    };
  }
}
