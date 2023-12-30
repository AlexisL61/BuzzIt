import 'package:buzzer/services/ws/WebsocketAction.dart';
import 'package:buzzer/services/ws/WebsocketMessage.dart';

class PlayerDataConfirmationMessage extends WebsocketConnectionMessage {
  static const String eventId = "playerDataConfirmation";

  @override
  List<WebsocketAction> actions = [];

  PlayerDataConfirmationMessage() : super(eventId);

  @override
  void hydrateData(data) {
  }

  @override
  toJson() {
    return {
      "event": event,
      "data": {"status":"OK"}
    };
  }
}