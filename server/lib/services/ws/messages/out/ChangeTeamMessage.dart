
import 'package:server/model/buzzerTeam.dart';
import 'package:server/services/ws/WebsocketAction.dart';
import 'package:server/services/ws/WebsocketMessage.dart';

class ChangeTeamMessage extends WebsocketConnectionMessage {
  static const String eventId = "changeTeam";

  late BuzzerTeam buzzerTeam;

  @override
  List<WebsocketAction> actions = [];

  ChangeTeamMessage() : super(eventId);

  @override
  void hydrateData(data) {}

  @override
  toJson() {
    return {"event": event, "data": {
      "team": buzzerTeam.name
    }};
  }
}
