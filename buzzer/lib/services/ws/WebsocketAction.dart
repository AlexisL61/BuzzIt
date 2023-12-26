import 'package:buzzer/model/InGame/ActivePlayer.dart';
import 'package:buzzer/services/ws/WebsocketMessage.dart';

abstract class WebsocketAction {
  WebsocketAction();

  void activate(ActivePlayer buzzer, WebsocketConnectionMessage message);
}
