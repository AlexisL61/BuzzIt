import 'package:server/model/Player.dart';
import 'package:server/services/router/ws/WebsocketAction.dart';
import 'package:server/services/router/ws/WebsocketMessage.dart';

class BuzzAction extends WebsocketAction {
  @override
  void activate(Player player, WebsocketConnectionMessage message) {
    player.buzz();
  }
}
