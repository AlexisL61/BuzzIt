import 'package:buzzer/model/buzzerState.dart';
import 'package:buzzer/services/ws/WebsocketAction.dart';
import 'package:buzzer/services/ws/WebsocketMessage.dart';
import 'package:buzzer/services/ws/messagesAction/ChangeBuzzerState.dart';

class BuzzStateMessage extends WebsocketConnectionMessage {
  static const String eventId = 'buzzState';
  late BuzzerState state;
  @override
  List<WebsocketAction> actions = [ChangeBuzzerStateAction()];

  BuzzStateMessage() : super(eventId);

  @override
  void hydrateData(data) {
    this.state = BuzzerStateExtension.fromString(data["state"]);
  }

  @override
  toJson() {
    return {
      "event": event,
      "data": {"state": state.toString()}
    };
  }
}
