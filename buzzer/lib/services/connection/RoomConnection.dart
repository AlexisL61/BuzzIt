import 'package:buzzer/model/InGame/ActivePlayer.dart';
import 'package:buzzer/model/InGame/InGameRoom.dart';
import 'package:buzzer/model/Player.dart';
import 'package:buzzer/model/Room.dart';
import 'package:buzzer/model/ServerInfo.dart';
import 'package:buzzer/services/api/ApiService.dart';

class RoomConnectionService {
  Future<InGameRoom?> createRoom(Player currentPlayer) async {
    Room? roomCreated = await ApiService().createRoom();
    print(roomCreated);
    if (roomCreated != null) {
      return await connectToRoom(roomCreated, currentPlayer);
    } else {
      return null;
    }
  }

  Future<InGameRoom> connectToRoom(Room room, Player currentPlayer) async {
    ActivePlayer player = ActivePlayer(currentPlayer.name, currentPlayer.image);
    ServerInfo serverInfo = await ApiService().getServerInfo();
    await player.init(serverInfo.wsUrl);
    return await player.joinRoom(room);
  }
}
