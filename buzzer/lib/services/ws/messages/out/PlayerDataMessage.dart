import 'package:buzzer/services/ws/WebsocketAction.dart';
import 'package:buzzer/services/ws/WebsocketMessage.dart';

class PlayerDataMessage extends WebsocketConnectionMessage {
  static const String eventId = "playerData";
  late String name;
  late String image;
  @override
  List<WebsocketAction> actions = [];

  PlayerDataMessage() : super(eventId);

  @override
  void hydrateData(data) {
    name = data["name"];
    image = data["image"];
  }

  @override
  toJson() {
    return {
      "event": event,
      "data": {"name": name, "image": image}
    };
  }
}