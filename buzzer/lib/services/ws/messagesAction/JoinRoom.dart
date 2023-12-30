import 'package:buzzer/model/InGame/ActivePlayer.dart';
import 'package:buzzer/services/ws/WebsocketAction.dart';
import 'package:buzzer/services/ws/WebsocketMessage.dart';
import 'package:buzzer/services/ws/messages/in/RoomJoinMessage.dart';

class ChangeTeamAction extends WebsocketAction {
  @override
  void activate(ActivePlayer buzzer, WebsocketConnectionMessage message) {
    RoomJoinMessage buzzStateMessage = message as RoomJoinMessage;
    // Change room code and join lobby

    buzzer.notifyListeners();
  }
}
