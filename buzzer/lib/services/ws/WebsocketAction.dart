import 'package:buzzer/model/buzzer.dart';
import 'package:buzzer/services/ws/WebsocketMessage.dart';

abstract class WebsocketAction {

  WebsocketAction();

  void activate(Buzzer buzzer, WebsocketConnectionMessage message);
}