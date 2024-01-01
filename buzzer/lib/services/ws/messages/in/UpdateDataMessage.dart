import 'package:buzzer/services/ws/WebsocketAction.dart';
import 'package:buzzer/services/ws/WebsocketMessage.dart';
import 'package:buzzer/services/ws/messagesAction/UpdateDataAction.dart';

class UpdateDataMessage extends WebsocketConnectionMessage {
  static const String eventId = "updateData";

  late String type;
  late Map<String, dynamic> updatedData;

  @override
  List<WebsocketAction> actions = [UpdatePlayerDataAction()];

  UpdateDataMessage() : super(eventId);

  @override
  void hydrateData(data) {
    type = data["type"];
    updatedData = data["updatedData"];
  }

  @override
  toJson() {
    return {
      "event": event,
      "data": {"type": type, "updatedData": updatedData}
    };
  }
}
