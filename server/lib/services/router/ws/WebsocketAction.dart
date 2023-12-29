import 'package:server/model/Player.dart';
import 'package:server/services/router/ws/WebsocketMessage.dart';

abstract class WebsocketAction {
  WebsocketAction();

  void activate(Player player, WebsocketConnectionMessage message);
}
