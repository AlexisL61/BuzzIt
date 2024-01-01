import 'package:server/services/router/ws/WebsocketAction.dart';
import 'package:server/services/router/ws/WebsocketMessage.dart';

class PingMessage extends WebsocketConnectionMessage {
  static const String eventId = 'ping';
  @override
  List<WebsocketAction> actions = [];

  PingMessage() : super(eventId);

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
