import 'package:buzzer/model/InGame/ActivePlayer.dart';
import 'package:buzzer/services/ws/WebsocketAction.dart';
import 'package:buzzer/services/ws/WebsocketMessage.dart';

class SendPongAction extends WebsocketAction {
  @override
  void activate(ActivePlayer buzzer, WebsocketConnectionMessage message) {
    buzzer.sendPong();
  }
}
