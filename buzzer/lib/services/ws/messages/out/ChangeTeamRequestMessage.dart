import 'package:buzzer/model/InGame/BuzzerTeam.dart';
import 'package:buzzer/services/ws/WebsocketAction.dart';
import 'package:buzzer/services/ws/WebsocketMessage.dart';

class ChangeTeamRequestMessage extends WebsocketConnectionMessage {
  late BuzzerTeam buzzerTeam;

  @override
  List<WebsocketAction> actions = [];

  ChangeTeamRequestMessage() : super('changeTeamRequest');

  @override
  void hydrateData(data) {}

  @override
  toJson() {
    return {"event": event, "data": {
      "team": buzzerTeam.name
    }};
  }
}
