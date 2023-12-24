import 'package:server/model/buzzer.dart';
import 'package:server/server.dart';
import 'package:server/services/ws/WebsocketAction.dart';
import 'package:server/services/ws/WebsocketMessage.dart';
import 'package:server/services/ws/messages/RoomChosenMessage.dart';

class AddBuzzerToRoomAction extends WebsocketAction {
  @override
  void activate(Buzzer buzzer, WebsocketConnectionMessage message) {
    RoomChosenMessage roomChosenMessage = message as RoomChosenMessage;
    if (buzzer.room == null) {
      Server().getRoomById(roomChosenMessage.roomId).addBuzzer(buzzer);
    }
  }
}
