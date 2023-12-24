import 'package:buzzer/model/buzzer.dart';
import 'package:buzzer/services/ws/WebsocketAction.dart';
import 'package:buzzer/services/ws/WebsocketMessage.dart';
import 'package:buzzer/services/ws/messages/BuzzStateMessage.dart';

class ChangeBuzzerStateAction extends WebsocketAction {
  @override
  void activate(Buzzer buzzer, WebsocketConnectionMessage message) {
    BuzzStateMessage buzzStateMessage = message as BuzzStateMessage;
    buzzer.state = buzzStateMessage.state;
    buzzer.notifyListeners();
  }
}
