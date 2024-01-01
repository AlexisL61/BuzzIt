import 'dart:convert';

import 'package:server/model/ConnectionToken.dart';
import 'package:server/model/Player.dart';
import 'package:server/model/ReconnectionToken.dart';
import 'package:server/model/Room.dart';
import 'package:server/server.dart';
import 'package:server/services/router/ws/WebsocketAction.dart';
import 'package:server/services/router/ws/WebsocketMessage.dart';
import 'package:server/services/router/ws/messages/in/RoomJoinRequestMessage.dart';
import 'package:server/services/router/ws/messages/in/RoomReconnectRequestMessage.dart';
import 'package:server/services/router/ws/messages/out/RoomJoinMessage.dart';

class ReconnectBuzzerToRoomAction extends WebsocketAction {
  @override
  void activate(Player player, WebsocketConnectionMessage message) {
    RoomReconnectRequestMessage roomReconnectMessage = message as RoomReconnectRequestMessage;
    if (player.room == null) {
      RoomJoinMessage roomJoinMessage = RoomJoinMessage();
      Reconnectiontoken? token =
          BuzzerServer().getReconnectionToken(roomReconnectMessage.reconnectionToken, roomReconnectMessage.roomId);
      if (token != null) {
        player.id = token.player.id;
        Room room = token.player.room!;
        room.switchPlayers(token.player, player);
        roomJoinMessage.room = room;
        roomJoinMessage.player = player;
        roomJoinMessage.reconnectionToken = BuzzerServer().generateReconnectionToken(player).token;
      } else {
        roomJoinMessage.room = null;
      }
      BuzzerServer().reconnectionTokens.remove(token);
      player.channel.sink.add(jsonEncode(roomJoinMessage.toJson()));
    }
  }
}
