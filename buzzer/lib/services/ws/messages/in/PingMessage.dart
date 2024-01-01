import 'package:buzzer/services/ws/WebsocketAction.dart';
import 'package:buzzer/services/ws/WebsocketMessage.dart';
import 'package:buzzer/services/ws/messagesAction/SendPongAction.dart';

class PingMessage extends WebsocketConnectionMessage {
  static const String eventId = 'ping';
  @override
  List<WebsocketAction> actions = [SendPongAction()];

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
