import 'package:buzzer/model/InGame/ActivePlayer.dart';
import 'package:buzzer/model/InGame/InGamePlayer.dart';

class InGameRoom {
  String id;
  List<InGamePlayer> players;
  InGamePlayer host;

  /// The buzzer of the player using the device
  ActivePlayer currentBuzzer;

  /// The buzzer that is currently active
  InGamePlayer? activeBuzzer;

  InGameRoom(this.id, this.currentBuzzer, this.host) : players = [currentBuzzer];

  void addPlayer(InGamePlayer player) {
    players.add(player);
  }

  void removePlayer(InGamePlayer player) {
    players.remove(player);
  }
}
