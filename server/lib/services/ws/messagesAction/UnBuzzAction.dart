import 'package:server/model/buzzer.dart';
import 'package:server/model/room.dart';
import 'package:server/server.dart';
import 'package:server/services/ws/WebsocketAction.dart';
import 'package:server/services/ws/WebsocketMessage.dart';
import 'package:server/services/ws/messages/in/RoomJoinRequestMessage.dart';

class UnBuzzAction extends WebsocketAction {
  @override
  void activate(Buzzer buzzer, WebsocketConnectionMessage message) {
    buzzer.room!.unbuzz();
  }
}
