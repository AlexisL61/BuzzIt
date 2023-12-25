import 'package:server/services/ws/WebsocketAction.dart';
import 'package:server/services/ws/WebsocketMessage.dart';
import 'package:server/services/ws/messagesAction/BuzzAction.dart';

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
