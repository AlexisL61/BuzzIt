import 'package:server/model/buzzerState.dart';
import 'package:server/model/buzzerTeam.dart';
import 'package:server/services/router/ws/WebsocketAction.dart';
import 'package:server/services/router/ws/WebsocketMessage.dart';

class BuzzStateMessage extends WebsocketConnectionMessage {
  static const String eventId = 'buzzState';
  late BuzzerState state;
  late BuzzerTeam? activeTeam;
  @override
  List<WebsocketAction> actions = [];

  BuzzStateMessage() : super(eventId);

  @override
  void hydrateData(data) {
    this.state = BuzzerStateExtension.fromString(data["state"]);
    this.activeTeam = BuzzerTeamExtension.fromString(data["activeTeam"]);
  }

  @override
  toJson() {
    return {
      "event": event,
      "data": {"state": state.name, "activeTeam": activeTeam?.name}
    };
  }
}
