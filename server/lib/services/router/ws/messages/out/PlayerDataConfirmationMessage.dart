import 'package:server/services/router/ws/WebsocketAction.dart';
import 'package:server/services/router/ws/WebsocketMessage.dart';

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
