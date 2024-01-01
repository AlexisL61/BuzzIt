import 'package:buzzer/model/InGame/ActivePlayer.dart';
import 'package:buzzer/model/InGame/InGamePlayer.dart';
import 'package:buzzer/model/InGame/InGameRoom.dart';
import 'package:buzzer/services/preferences/UserPreferencesService.dart';
import 'package:buzzer/services/ws/WebsocketAction.dart';
import 'package:buzzer/services/ws/WebsocketMessage.dart';

class RoomJoinMessage extends WebsocketConnectionMessage {
  static const String eventId = "roomJoin";

  late String status;
  late Map<String, dynamic> inGameRoomData;
  late InGamePlayer player;
  late String reconnectToken;
  @override
  List<WebsocketAction> actions = [];

  RoomJoinMessage() : super(eventId);

  @override
  void hydrateData(data) {
    status = data["status"];
    if (data["status"] != "OK") {
      return;
    }
    inGameRoomData = data["room"];
    player = InGamePlayer.fromJson(data["player"]);
    reconnectToken = data["reconnectiontoken"];
  }

  InGameRoom getInGameRoomWithActivePlayer(ActivePlayer activePlayer) {
    InGameRoom roomCreated = InGameRoom.fromJson(inGameRoomData, activePlayer);
    activePlayer.id = player.id;
    UserPreferencesService().setLatestRoomCode(roomCreated.id);
    UserPreferencesService().setReconnectionToken(reconnectToken);

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
