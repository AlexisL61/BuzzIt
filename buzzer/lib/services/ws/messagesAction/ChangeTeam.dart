import 'package:buzzer/model/InGame/ActivePlayer.dart';
import 'package:buzzer/services/ws/WebsocketAction.dart';
import 'package:buzzer/services/ws/WebsocketMessage.dart';
import 'package:buzzer/services/ws/messages/in/ChangeTeamMessage.dart';

class ChangeTeamAction extends WebsocketAction {
  @override
  void activate(ActivePlayer buzzer, WebsocketConnectionMessage message) {
    ChangeTeamMessage buzzStateMessage = message as ChangeTeamMessage;
    buzzer.team = buzzStateMessage.buzzerTeam;
    buzzer.notifyListeners();
  }
}
