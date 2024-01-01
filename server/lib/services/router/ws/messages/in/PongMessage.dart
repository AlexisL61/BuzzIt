
import 'package:server/services/router/ws/WebsocketAction.dart';
import 'package:server/services/router/ws/WebsocketMessage.dart';

class PongMessage extends WebsocketConnectionMessage {
  static const String eventId = 'pong';
  @override
  List<WebsocketAction> actions = [];

  PongMessage() : super(eventId);

  @override
  void hydrateData(data) {
    
  }

  @override
  toJson() {
    return {
      "event": event,
      "data": null
    };
  }
}
