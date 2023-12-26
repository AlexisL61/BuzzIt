import 'package:buzzer/model/buzzer.dart';
import 'package:buzzer/services/ws/WebsocketAction.dart';
import 'package:buzzer/services/ws/WebsocketMessage.dart';
import 'package:buzzer/services/ws/messages/in/ChangeTeamMessage.dart';

class ChangeTeamAction extends WebsocketAction {
  @override
  void activate(Buzzer buzzer, WebsocketConnectionMessage message) {
    ChangeTeamMessage buzzStateMessage = message as ChangeTeamMessage;
    buzzer.team = buzzStateMessage.buzzerTeam;
    buzzer.notifyListeners();
  }
}