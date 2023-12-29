import 'dart:convert';

import 'package:server/model/Player.dart';
import 'package:server/services/router/ws/WebsocketAction.dart';
import 'package:server/services/router/ws/WebsocketMessage.dart';
import 'package:server/services/router/ws/messages/out/ChangeTeamMessage.dart';
import 'package:server/services/router/ws/messages/in/ChangeTeamRequestMessage.dart';

class ChangeTeamRequestAction extends WebsocketAction {
  @override
  void activate(Player player, WebsocketConnectionMessage message) {
    ChangeTeamRequestMessage changeTeamRequestMessage =
        message as ChangeTeamRequestMessage;
    player.team = changeTeamRequestMessage.buzzerTeam;
    ChangeTeamMessage changeTeamMessage = ChangeTeamMessage();
    changeTeamMessage.buzzerTeam = player.team;
    player.channel.sink.add(jsonEncode(changeTeamMessage.toJson()));
  }
}
