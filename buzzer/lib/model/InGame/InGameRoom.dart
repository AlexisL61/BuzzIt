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

  List<Function> _playerUpdateListeners = [];
  List<Function> _activePlayerUpdateListeners = [];

  InGameRoom(this.id, this.currentPlayer, this.host) : players = [host];

  void addPlayer(InGamePlayer player) {
    players.add(player);
  }

  void removePlayer(InGamePlayer player) {
    players.remove(player);
  }

  static InGameRoom fromJson(
      Map<String, dynamic> json, ActivePlayer currentPlayer) {
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

  void addPlayerUpdateListener(Function(InGamePlayer) listener) {
    _playerUpdateListeners.add(listener);
  }

  void notifyPlayerUpdate(InGamePlayer player) {
    _playerUpdateListeners.forEach((element) {
      element(player);
    });
  }

  void addActivePlayerUpdateListener(Function(InGamePlayer?) listener) {
    _activePlayerUpdateListeners.add(listener);
  }

  void notifyActivePlayerUpdate(InGamePlayer? player) {
    _activePlayerUpdateListeners.forEach((element) {
      element(player);
    });
  }

  void updateFromUpdateData(Map<String, dynamic> updatedData) {
    if (updatedData["players"] != null) {
      updatePlayers(updatedData["players"]);
    }

    if (updatedData['activePlayer'] != null) {
      for (InGamePlayer player in players) {
        if (player.id == updatedData['activePlayer']) {
          activePlayer = player;
          break;
        }
      }
    } else {
      activePlayer = null;
    }
    notifyActivePlayerUpdate(activePlayer);
  }

  void updatePlayers(List<dynamic> players) {
    for (dynamic player in players) {
      bool found = false;
      for (InGamePlayer roomPlayer in this.players) {
        if (roomPlayer.id == player["id"]) {
          found = true;
          break;
        }
      }
      if (!found) {
        addPlayer(InGamePlayer.fromJson(player));
      }
    }

    List<InGamePlayer> playersToRemove = [];
    for (InGamePlayer roomPlayer in this.players) {
      bool found = false;
      for (dynamic player in players) {
        if (roomPlayer.id == player["id"]) {
          found = true;
          break;
        }
      }
      if (!found) {
        playersToRemove.add(roomPlayer);
      }
    }

    for (InGamePlayer player in playersToRemove) {
      removePlayer(player);
    }
  }
}
