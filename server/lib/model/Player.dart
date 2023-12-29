import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'buzzerState.dart';
import 'package:server/server.dart';
import 'Room.dart';
import 'package:collection/collection.dart';
import 'buzzerTeam.dart';
import 'package:server/services/router/ws/messages/out/BuzzStateMessage.dart';

class Player {
  WebSocketChannel channel;
  String name;
  String image;
  BuzzerState _state;
  BuzzerTeam team = BuzzerTeam.NONE;

  Player(this.channel, this.name, this.image) : _state = BuzzerState.IDLE;

  void buzz() {
    if (room != null) {
      room!.playerActivated(this);
    }
  }

  Room? get room {
    return BuzzerServer()
        .rooms
        .firstWhereOrNull((Room element) => element.buzzers.contains(this));
  }

  BuzzerState get state => _state;

  set state(BuzzerState value) {
    _state = value;
    BuzzStateMessage message = BuzzStateMessage();
    message.state = value;
    if (room?.activeBuzzerTeam != null) {
      message.activeTeam = room!.activeBuzzerTeam!;
    } else {
      message.activeTeam = null;
    }
    channel.sink.add(jsonEncode(message.toJson()));
  }

  Map<String, dynamic> toPartialJson() {
    return {'name': name, 'image': image};
  }
}
