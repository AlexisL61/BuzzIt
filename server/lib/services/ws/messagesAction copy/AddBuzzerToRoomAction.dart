import 'package:server/model/buzzer.dart';
import 'package:server/server.dart';
import 'package:server/services/ws/WebsocketAction.dart';
import 'package:server/services/ws/WebsocketMessage.dart';
import 'package:server/services/ws/messages/in/RoomJoinRequestMessage.dart';

class AddBuzzerToRoomAction extends WebsocketAction {
  @override
  void activate(Buzzer buzzer, WebsocketConnectionMessage message) {
    RoomJoinRequestMessage roomChosenMessage =
        message as RoomJoinRequestMessage;
    if (buzzer.room == null) {
      Server().getRoomById(roomChosenMessage.roomId).addBuzzer(buzzer);
    }
  }
}
