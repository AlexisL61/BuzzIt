import 'package:buzzer/services/ws/WebsocketAction.dart';
import 'package:buzzer/services/ws/WebsocketMessage.dart';

class UnBuzzMessage extends WebsocketConnectionMessage {
  @override
  List<WebsocketAction> actions = [];

  UnBuzzMessage() : super('unbuzz');

  @override
  void hydrateData(data) {}

  @override
  toJson() {
    return {"event": event, "data": null};
  }
}
