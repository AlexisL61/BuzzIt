import 'package:buzzer/model/buzzer.dart';
import 'package:buzzer/model/player.dart';

class Room {
  String id;
  List<Player> players;

  /// The buzzer of the player using the device
  Buzzer currentBuzzer;

  /// The buzzer that is currently active
  Player? activeBuzzer;

  Room(this.id, this.currentBuzzer) : players = [currentBuzzer];

  void addPlayer(Player player) {
    players.add(player);
  }

  void removePlayer(Player player) {
    players.remove(player);
  }
}
