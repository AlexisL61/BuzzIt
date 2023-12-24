import 'package:buzzer/model/buzzerTeam.dart';
import 'package:buzzer/services/ws/WebsocketClient.dart';
import 'package:buzzer/services/ws/messages/BuzzMessage.dart';
import 'package:buzzer/services/ws/messages/ChangeTeamRequestMessage.dart';
import 'package:buzzer/services/ws/messages/RoomChosenMessage.dart';
import 'package:buzzer/services/ws/messages/UnBuzzMessage.dart';
import 'buzzerState.dart';

class Buzzer {
  BuzzerState state;
  BuzzerTeam team = BuzzerTeam.BLUE;
  BuzzerTeam ennemyTeam = BuzzerTeam.RED;
  WebsocketClient client = WebsocketClient();
  List<Function> _listeners = [];

  Buzzer() : state = BuzzerState.IDLE;

  Future<void> init() async {
    await client.connect(this);
    RoomChosenMessage roomChosenMessage = RoomChosenMessage();
    roomChosenMessage.roomId = "1";
    client.send(roomChosenMessage);
  }

  void buzz() {
    client.send(BuzzMessage());
  }

  void changeTeam(){
    int currentTeamIndex = BuzzerTeam.values.indexOf(team);
    int nextTeamIndex = (currentTeamIndex + 1) % BuzzerTeam.values.length;
    BuzzerTeam teamFound = BuzzerTeam.values[nextTeamIndex];
    ChangeTeamRequestMessage changeTeamRequestMessage = ChangeTeamRequestMessage();
    changeTeamRequestMessage.buzzerTeam = teamFound;
    client.send(changeTeamRequestMessage);
  }

  void unbuzz() {
    client.send(UnBuzzMessage());
  }

  void addListener(Function listener) {
    _listeners.add(listener);
  }

  void removeListener(Function listener) {
    _listeners.remove(listener);
  }

  void notifyListeners() {
    _listeners.forEach((element) {
      element();
    });
  }
}
