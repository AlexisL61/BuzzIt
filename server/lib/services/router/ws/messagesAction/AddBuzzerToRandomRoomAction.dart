import 'package:server/model/Player.dart';
import 'package:server/server.dart';
import 'package:server/services/router/ws/WebsocketAction.dart';
import 'package:server/services/router/ws/WebsocketMessage.dart';

class AddBuzzerToRoomAction extends WebsocketAction {
  @override
  void activate(Player buzzer, WebsocketConnectionMessage message) {
    if (buzzer.room == null) {
      BuzzerServer().getRandomRoom().addPlayer(buzzer);
    }
  }
}
