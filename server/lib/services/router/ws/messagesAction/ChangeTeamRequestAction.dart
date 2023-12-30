import 'dart:convert';

import 'package:server/model/Player.dart';
import 'package:server/services/router/ws/WebsocketAction.dart';
import 'package:server/services/router/ws/WebsocketMessage.dart';
import 'package:server/services/router/ws/messages/in/ChangeTeamRequestMessage.dart';
import 'package:server/services/router/ws/messages/out/UpdateDataMessage.dart';

class ChangeTeamRequestAction extends WebsocketAction {
  @override
  void activate(Player player, WebsocketConnectionMessage message) {
    ChangeTeamRequestMessage changeTeamRequestMessage =
        message as ChangeTeamRequestMessage;
    player.team = changeTeamRequestMessage.buzzerTeam;
    UpdateDataMessage activePlayerDataMessage =
        UpdateDataMessage.fromActivePlayer(player);
    player.channel.sink.add(jsonEncode(activePlayerDataMessage.toJson()));
    UpdateDataMessage playerDataMessage = UpdateDataMessage.fromPlayer(player);
    player.room!.sendToAll(jsonEncode(playerDataMessage.toJson()));
  }
}
