import 'package:server/services/ws/WebsocketAction.dart';
import 'package:server/services/ws/WebsocketMessage.dart';
import 'package:server/services/ws/messagesAction/UnBuzzAction.dart';

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
