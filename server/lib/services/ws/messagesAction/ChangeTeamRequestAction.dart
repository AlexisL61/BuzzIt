import 'dart:convert';

import 'package:server/model/buzzer.dart';
import 'package:server/model/room.dart';
import 'package:server/server.dart';
import 'package:server/services/ws/WebsocketAction.dart';
import 'package:server/services/ws/WebsocketMessage.dart';
import 'package:server/services/ws/messages/ChangeTeamMessage.dart';
import 'package:server/services/ws/messages/ChangeTeamRequestMessage.dart';
import 'package:server/services/ws/messages/RoomChosenMessage.dart';

class ChangeTeamRequestAction extends WebsocketAction {
  @override
  void activate(Buzzer buzzer, WebsocketConnectionMessage message) {
    ChangeTeamRequestMessage changeTeamRequestMessage = message as ChangeTeamRequestMessage;
    buzzer.team = changeTeamRequestMessage.buzzerTeam;
    ChangeTeamMessage changeTeamMessage = ChangeTeamMessage();
    changeTeamMessage.buzzerTeam = buzzer.team;
    buzzer.channel.sink.add(jsonEncode(changeTeamMessage.toJson()));
    
  }
}
