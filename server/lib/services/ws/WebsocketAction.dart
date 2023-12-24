import 'package:server/model/buzzer.dart';
import 'package:server/services/ws/WebsocketMessage.dart';

abstract class WebsocketAction {

  WebsocketAction();

  void activate(Buzzer buzzer, WebsocketConnectionMessage message);
}