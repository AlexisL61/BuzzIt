import 'package:server/model/Player.dart';
import 'package:server/server.dart';
import 'package:server/services/router/ws/WebsocketAction.dart';
import 'package:server/services/router/ws/WebsocketMessage.dart';
import 'package:server/services/router/ws/messages/in/RoomJoinRequestMessage.dart';
import 'package:server/services/router/ws/messages/out/RoomJoinMessage.dart';

class AddBuzzerToRoomAction extends WebsocketAction {
  @override
  void activate(Player player, WebsocketConnectionMessage message) {
    RoomJoinRequestMessage roomChosenMessage =
        message as RoomJoinRequestMessage;
    if (player.room == null) {
      RoomJoinMessage roomJoinMessage = RoomJoinMessage();
      roomJoinMessage.room =
          BuzzerServer().getRoomById(roomChosenMessage.roomId);
      player.channel.sink.add(roomJoinMessage.toJson());
    }
  }
}
