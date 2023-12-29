import 'package:server/services/router/ws/WebsocketAction.dart';
import 'package:server/services/router/ws/WebsocketMessage.dart';
import 'package:server/services/router/ws/messagesAction/BuzzAction.dart';

class BuzzMessage extends WebsocketConnectionMessage {
  static const String eventId = 'buzz';

  @override
  List<WebsocketAction> actions = [BuzzAction()];

  BuzzMessage() : super(eventId);

  @override
  void hydrateData(data) {}

  @override
  toJson() {
    return {"event": event, "data": null};
  }
}
