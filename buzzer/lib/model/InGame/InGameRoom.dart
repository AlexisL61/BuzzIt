import 'package:buzzer/model/InGame/ActivePlayer.dart';
import 'package:buzzer/model/InGame/InGamePlayer.dart';

class InGameRoom {
  String id;
  List<InGamePlayer> players;
  InGamePlayer host;

  /// The buzzer of the player using the device
  ActivePlayer currentPlayer;

  /// The buzzer that is currently active
  InGamePlayer? activePlayer;

  InGameRoom(this.id, this.currentPlayer, this.host) : players = [host];

  void addPlayer(InGamePlayer player) {
    players.add(player);
  }

  void removePlayer(InGamePlayer player) {
    players.remove(player);
  }

  static InGameRoom fromJson(
      Map<String, dynamic> json, ActivePlayer currentPlayer) {
    print(json);
    InGameRoom room = InGameRoom(
        json['id'], currentPlayer, InGamePlayer.fromJson(json['host']));
    json['players'].forEach((element) {
      room.addPlayer(InGamePlayer.fromJson(element));
    });
    return room;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'host': host.toJson(),
      'players': players.map((e) => e.toJson()).toList()
    };
  }
}
