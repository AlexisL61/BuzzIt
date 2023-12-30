import 'package:buzzer/model/InGame/ActivePlayer.dart';
import 'package:buzzer/services/ws/WebsocketAction.dart';
import 'package:buzzer/services/ws/WebsocketMessage.dart';
import 'package:buzzer/services/ws/messages/in/UpdateDataMessage.dart';

class UpdatePlayerDataAction extends WebsocketAction {
  @override
  void activate(ActivePlayer buzzer, WebsocketConnectionMessage message) {
    UpdateDataMessage updatePlayerDataMessage = message as UpdateDataMessage;
    if (updatePlayerDataMessage.type == "player") {
      for (var player in buzzer.room!.players) {
        if (player.id == updatePlayerDataMessage.updatedData["id"]) {
          player.updateFromUpdateData(updatePlayerDataMessage.updatedData);
        }
      }
    } else if (updatePlayerDataMessage.type == "room") {
      buzzer.room!.updateFromUpdateData(updatePlayerDataMessage.updatedData);
    } else if (updatePlayerDataMessage.type == "activePlayer") {
      buzzer.updateFromUpdateData(updatePlayerDataMessage.updatedData);
    }
  }
}
