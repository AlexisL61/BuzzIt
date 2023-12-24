import 'package:server/model/buzzerState.dart';
import 'package:server/services/ws/WebsocketAction.dart';
import 'package:server/services/ws/WebsocketMessage.dart';

class BuzzStateMessage extends WebsocketConnectionMessage {
  static const String eventId = 'buzzState';
  late BuzzerState state;
  @override
  List<WebsocketAction> actions = [];

  BuzzStateMessage() : super(eventId);

  @override
  void hydrateData(data) {
    this.state = BuzzerStateExtension.fromString(data["state"]);
  }

  @override
  toJson() {
    return {
      "event": event,
      "data": {"state": state.name}
    };
  }
}
