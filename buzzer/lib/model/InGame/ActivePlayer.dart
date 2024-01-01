import 'package:buzzer/model/InGame/BuzzerTeam.dart';
import 'package:buzzer/model/InGame/InGamePlayer.dart';
import 'package:buzzer/model/InGame/InGameRoom.dart';
import 'package:buzzer/model/Room.dart';
import 'package:buzzer/services/ws/WebsocketClient.dart';
import 'package:buzzer/services/ws/messages/in/RoomJoinMessage.dart';
import 'package:buzzer/services/ws/messages/out/BuzzMessage.dart';
import 'package:buzzer/services/ws/messages/out/ChangeTeamRequestMessage.dart';
import 'package:buzzer/services/ws/messages/out/PongMessage.dart';
import 'package:buzzer/services/ws/messages/out/RoomJoinRequestMessage.dart';
import 'package:buzzer/services/ws/messages/out/RoomReconnectRequestMessage.dart';
import 'package:buzzer/services/ws/messages/out/UnBuzzMessage.dart';
import 'BuzzerState.dart';

class ActivePlayer extends InGamePlayer {
  BuzzerState state;
  BuzzerTeam ennemyTeam = BuzzerTeam.RED;
  WebsocketClient client = WebsocketClient();
  List<Function> _listeners = [];
  InGameRoom? room;

  ActivePlayer(String name, String image)
      : state = BuzzerState.IDLE,
        super("ACTIVE_PLAYER", name, image);

  Future<void> init(String wsServer) async {
    await client.connect(this, wsServer);
  }

  Future<T> waitMessage<T>() async {
    return await client.waitMessage<T>();
  }

  Future<InGameRoom> joinRoom(Room room) async {
    RoomJoinRequestMessage roomJoinRequestMessage = RoomJoinRequestMessage();
    roomJoinRequestMessage.roomId = room.id;
    roomJoinRequestMessage.token = room.connectionToken;
    client.send(roomJoinRequestMessage);
    RoomJoinMessage roomJoinMessage = await waitMessage<RoomJoinMessage>();
    InGameRoom inGameRoom = roomJoinMessage.getInGameRoomWithActivePlayer(this);
    this.room = inGameRoom;
    return inGameRoom;
  }

  Future<InGameRoom?> reconnect(
      String roomCode, String reconnectionToken) async {
    RoomReconnectRequestMessage roomReconnectRequestMessage =
        RoomReconnectRequestMessage();
    roomReconnectRequestMessage.roomId = roomCode;
    roomReconnectRequestMessage.reconnectionToken = reconnectionToken;
    client.send(roomReconnectRequestMessage);
    RoomJoinMessage roomJoinMessage = await waitMessage<RoomJoinMessage>();
    print(roomJoinMessage.status);
    if (roomJoinMessage.status == "OK") {
      InGameRoom inGameRoom =
          roomJoinMessage.getInGameRoomWithActivePlayer(this);
      this.room = inGameRoom;
      return inGameRoom;
    } else {
      return null;
    }
  }

  void buzz() {
    client.send(BuzzMessage());
  }

  void changeTeam() {
    int currentTeamIndex = BuzzerTeam.values.indexOf(team);
    int nextTeamIndex = (currentTeamIndex + 1) % BuzzerTeam.values.length;
    BuzzerTeam teamFound = BuzzerTeam.values[nextTeamIndex];
    ChangeTeamRequestMessage changeTeamRequestMessage =
        ChangeTeamRequestMessage();
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

  void sendPong() {
    client.send(PongMessage());
  }

  @override
  void updateFromUpdateData(Map<String, dynamic> data) {
    this.state = BuzzerStateExtension.fromString(data['state']);
    super.updateFromUpdateData(data);
    notifyListeners();
  }

  static ActivePlayer fromJson(Map<String, dynamic> json) {
    ActivePlayer player = ActivePlayer(json['name'], json['image']);
    player.team = BuzzerTeam.values[json['team']];
    player.state = BuzzerState.values[json['state']];
    return player;
  }
}
