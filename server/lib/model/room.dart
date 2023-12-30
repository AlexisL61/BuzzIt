import 'package:server/model/ConnectionToken.dart';
import 'package:server/model/Player.dart';
import 'package:server/model/buzzerState.dart';
import 'package:server/model/buzzerTeam.dart';
import 'package:server/server.dart';

class Room {
  String id;
  List<Player> buzzers;
  Player? host;
  Player? activeBuzzer;

  Room(this.id) : buzzers = [];

  void addPlayer(Player buzzer) {
    if (buzzers.length == 0) host = buzzer;
    buzzers.add(buzzer);
  }

  void removePlayer(Player buzzer) {
    buzzers.remove(buzzer);
  }

  void playerActivated(Player buzzer) {
    if (activeBuzzer != null) return;
    activeBuzzer = buzzer;
    buzzers.forEach((element) {
      if (element != buzzer) {
        if (element.team == activeBuzzerTeam)
          element.state = BuzzerState.LOCKED_BY_TEAM;
        else
          element.state = BuzzerState.LOCKED_BY_ENNEMY;
      }
    });
    buzzer.state = BuzzerState.BUZZED;
  }

  BuzzerTeam? get activeBuzzerTeam {
    if (activeBuzzer == null) return null;
    return activeBuzzer!.team;
  }

  void unbuzz() {
    if (activeBuzzer == null) return;
    activeBuzzer!.state = BuzzerState.IDLE;
    activeBuzzer = null;
    buzzers.forEach((element) {
      element.state = BuzzerState.IDLE;
    });
  }

  Map<String, dynamic> toPartialJson() {
    return {
      'id': id,
      'playersNumber': buzzers.length,
      'host': host!=null?host!.toPartialJson():null
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'host': host!.toJson(),
      'players': buzzers.map((e) => e.toJson()).toList()
    };
  }

  ConnectionToken generateConnectionToken() {
    return BuzzerServer().generateConnectionToken(this);
  }
}
