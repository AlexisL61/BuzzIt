import 'package:buzzer/services/ws/WebsocketAction.dart';
import 'package:buzzer/services/ws/WebsocketMessage.dart';
import 'package:buzzer/services/ws/messagesAction/ChangeBuzzerState.dart';

class BuzzMessage extends WebsocketConnectionMessage {
  @override
  List<WebsocketAction> actions = [ChangeBuzzerStateAction()];

  BuzzMessage() : super('buzz');

  @override
  void hydrateData(data) {}

  @override
  toJson() {
    return {"event": event, "data": null};
  }
}
