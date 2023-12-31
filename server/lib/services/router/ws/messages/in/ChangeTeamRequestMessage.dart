
import 'package:server/model/buzzerTeam.dart';
import 'package:server/services/router/ws/WebsocketAction.dart';
import 'package:server/services/router/ws/WebsocketMessage.dart';
import 'package:server/services/router/ws/messagesAction/ChangeTeamRequestAction.dart';

class ChangeTeamRequestMessage extends WebsocketConnectionMessage {
  static const String eventId = 'changeTeamRequest';
  late BuzzerTeam buzzerTeam;

  @override
  List<WebsocketAction> actions = [ChangeTeamRequestAction()];

  ChangeTeamRequestMessage() : super(eventId);

  @override
  void hydrateData(data) {
    buzzerTeam = BuzzerTeamExtension.fromString(data["team"]);
  }

  @override
  toJson() {
    return {"event": event, "data": {
      "team": buzzerTeam.name
    }};
  }
}
