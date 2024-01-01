import 'package:buzzer/model/InGame/BuzzerState.dart';
import 'package:buzzer/model/InGame/BuzzerTeam.dart';
import 'package:buzzer/services/ws/WebsocketAction.dart';
import 'package:buzzer/services/ws/WebsocketMessage.dart';
import 'package:buzzer/services/ws/messagesAction/ChangeBuzzerState.dart';

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
