import 'dart:convert';

import 'package:server/model/ConnectionToken.dart';
import 'package:server/model/Player.dart';
import 'package:server/server.dart';
import 'package:server/services/router/ws/WebsocketAction.dart';
import 'package:server/services/router/ws/WebsocketMessage.dart';
import 'package:server/services/router/ws/messages/in/RoomJoinRequestMessage.dart';
import 'package:server/services/router/ws/messages/out/RoomJoinMessage.dart';
import 'package:server/services/router/ws/messages/out/UpdateDataMessage.dart';

class AddBuzzerToRoomAction extends WebsocketAction {
  @override
  void activate(Player player, WebsocketConnectionMessage message) {
    RoomJoinRequestMessage roomChosenMessage =
        message as RoomJoinRequestMessage;
    if (player.room == null) {
      RoomJoinMessage roomJoinMessage = RoomJoinMessage();
      ConnectionToken? token = BuzzerServer().getConnectionToken(
          roomChosenMessage.token, roomChosenMessage.roomId);
      if (token != null) {
        token.room.addPlayer(player);
        roomJoinMessage.room = token.room;
        roomJoinMessage.player = player;
        roomJoinMessage.reconnectionToken =
            BuzzerServer().generateReconnectionToken(player).token;
      } else {
        roomJoinMessage.room = null;
      }
      player.channel.sink.add(jsonEncode(roomJoinMessage.toJson()));

      UpdateDataMessage updateDataMessage =
          UpdateDataMessage.fromRoom(roomJoinMessage.room!);
      roomJoinMessage.room!.sendToAll(jsonEncode(updateDataMessage.toJson()));
    }
  }
}
