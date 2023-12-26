import 'package:buzzer/model/InGame/BuzzerTeam.dart';
import 'package:buzzer/services/ws/WebsocketAction.dart';
import 'package:buzzer/services/ws/WebsocketMessage.dart';
import 'package:buzzer/services/ws/messagesAction/ChangeTeam.dart';

class ChangeTeamMessage extends WebsocketConnectionMessage {
  static const String eventId = "changeTeam";

  late BuzzerTeam buzzerTeam;

  @override
  List<WebsocketAction> actions = [ChangeTeamAction()];

  ChangeTeamMessage() : super(eventId);

  @override
  void hydrateData(data) {
    this.buzzerTeam = BuzzerTeamExtension.fromString(data["team"]);
  }

  @override
  toJson() {
    return {"event": event, "data": {
      "team": buzzerTeam.name
    }};
  }
}
