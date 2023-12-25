import 'package:buzzer/model/buzzer.dart';
import 'package:buzzer/services/ws/WebsocketAction.dart';
import 'package:buzzer/services/ws/WebsocketMessage.dart';
import 'package:buzzer/services/ws/messages/in/ChangeTeamMessage.dart';
import 'package:buzzer/services/ws/messages/in/RoomJoinMessage.dart';

class ChangeTeamAction extends WebsocketAction {
  @override
  void activate(Buzzer buzzer, WebsocketConnectionMessage message) {
    RoomJoinMessage buzzStateMessage = message as RoomJoinMessage;
    // Change room code and join lobby
    
    buzzer.notifyListeners();
  }
}
