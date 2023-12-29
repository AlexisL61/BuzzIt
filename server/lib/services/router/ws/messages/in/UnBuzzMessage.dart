import 'package:server/services/router/ws/WebsocketAction.dart';
import 'package:server/services/router/ws/WebsocketMessage.dart';
import 'package:server/services/router/ws/messagesAction/UnBuzzAction.dart';

class UnBuzzMessage extends WebsocketConnectionMessage {
  static const String eventId = 'unbuzz';
  
  @override
  List<WebsocketAction> actions = [UnBuzzAction()];

  UnBuzzMessage() : super(eventId);

  @override
  void hydrateData(data) {}

  @override
  toJson() {
    return {"event": event, "data": null};
  }
}
