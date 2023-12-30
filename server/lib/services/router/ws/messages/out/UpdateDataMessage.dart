import 'package:server/model/Player.dart';
import 'package:server/model/Room.dart';
import 'package:server/services/router/ws/WebsocketAction.dart';
import 'package:server/services/router/ws/WebsocketMessage.dart';

class UpdateDataMessage extends WebsocketConnectionMessage {
  static const String eventId = "updateData";


  late String type;
  late Map<String, dynamic> updatedData;

  @override
  List<WebsocketAction> actions = [];

  UpdateDataMessage() : super(eventId);

  factory UpdateDataMessage.fromPlayer(Player player) {
    UpdateDataMessage updateDataMessage = UpdateDataMessage();
    updateDataMessage.type = "player";
    updateDataMessage.updatedData = player.toJson();
    updateDataMessage.updatedData.remove("state");
    return updateDataMessage;
  }

  factory UpdateDataMessage.fromRoom(Room room) {
    UpdateDataMessage updateDataMessage = UpdateDataMessage();
    updateDataMessage.type = "room";
    updateDataMessage.updatedData = room.toJson();
    return updateDataMessage;
  }

  factory UpdateDataMessage.fromActivePlayer(Player player) {
    UpdateDataMessage updateDataMessage = UpdateDataMessage();
    updateDataMessage.type = "activePlayer";
    updateDataMessage.updatedData = player.toJson();
    return updateDataMessage;
  }

  @override
  void hydrateData(data) {
  }

  @override
  toJson() {
    return {
      "event": event,
      "data": {
        "type": type,
        "updatedData": updatedData
      }
    };
  }
}