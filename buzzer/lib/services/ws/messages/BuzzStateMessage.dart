import 'package:buzzer/model/buzzerState.dart';
import 'package:buzzer/model/buzzerTeam.dart';
import 'package:buzzer/services/ws/WebsocketAction.dart';
import 'package:buzzer/services/ws/WebsocketMessage.dart';
import 'package:buzzer/services/ws/messagesAction/ChangeBuzzerState.dart';

class BuzzStateMessage extends WebsocketConnectionMessage {
  static const String eventId = 'buzzState';
  late BuzzerState state;
  late BuzzerTeam? activeTeam;
  @override
  List<WebsocketAction> actions = [ChangeBuzzerStateAction()];

  BuzzStateMessage() : super(eventId);

  @override
  void hydrateData(data) {
    this.state = BuzzerStateExtension.fromString(data["state"]);
    if (data["activeTeam"] != null)
    this.activeTeam = BuzzerTeamExtension.fromString(data["activeTeam"]);
    else 
    this.activeTeam = null;
  }

  @override
  toJson() {
    return {
      "event": event,
      "data": {"state": state.name, "activeTeam": activeTeam?.name}
    };
  }
}
