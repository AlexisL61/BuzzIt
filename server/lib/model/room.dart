import 'dart:convert';

import 'package:server/model/ConnectionToken.dart';
import 'package:server/model/Player.dart';
import 'package:server/model/buzzerTeam.dart';
import 'package:server/server.dart';
import 'package:collection/collection.dart';
import 'package:server/services/router/ws/messages/out/UpdateDataMessage.dart';

class Room {
  String id;
  List<Player> players;
  Player? host;
  Player? activePlayer;

  Room(this.id) : players = [];

  void addPlayer(Player buzzer) {
    if (players.length == 0) host = buzzer;
    players.add(buzzer);
  }

  void removePlayer(Player buzzer) {
    players.remove(buzzer);
    if (players.length == 0) {
      BuzzerServer().rooms.remove(this);
    }
  }

  void playerActivated(Player buzzer) {
    if (activePlayer != null) return;
    activePlayer = buzzer;
    UpdateDataMessage message = UpdateDataMessage.fromRoom(this);
    sendToAll(jsonEncode(message.toJson()));
  }

  BuzzerTeam? get activeBuzzerTeam {
    if (activePlayer == null) return null;
    return activePlayer!.team;
  }

  void sendToAll(event) {
    players.forEach((element) {
      element.channel.sink.add(event);
    });
  }

  void unbuzz() {
    activePlayer = null;
    UpdateDataMessage message = UpdateDataMessage.fromRoom(this);
    sendToAll(jsonEncode(message.toJson()));
  }

  Map<String, dynamic> toPartialJson() {
    return {
      'id': id,
      'playersNumber': players.length,
      'host': host != null ? host!.toPartialJson() : null
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'host': host!.toJson(),
      'players': players.map((e) => e.toJson()).toList(),
      'activePlayer': activePlayer != null ? activePlayer!.id : null,
    };
  }

  ConnectionToken generateConnectionToken() {
    return BuzzerServer().generateConnectionToken(this);
  }

  void playerBecomeInactive(Player player) {
    if (host == player) {
      host = players.firstWhereOrNull((element) => element != player);
    }
    if (activePlayer == player) {
      unbuzz();
    }
  }
}
