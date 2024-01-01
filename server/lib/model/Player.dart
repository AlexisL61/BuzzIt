import 'dart:convert';
import 'package:server/services/generator/PlayerIdGenerator.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'buzzerState.dart';
import 'package:server/server.dart';
import 'Room.dart';
import 'package:collection/collection.dart';
import 'buzzerTeam.dart';
import 'package:server/services/router/ws/messages/out/BuzzStateMessage.dart';

class Player {
  WebSocketChannel channel;
  String id = PlayerIdGenerator.generateId();
  String name;
  String image;
  bool _inactive = false;
  BuzzerState _state;
  BuzzerTeam team = BuzzerTeam.BLUE;

  Player(this.channel, this.name, this.image) : _state = BuzzerState.IDLE;

  void buzz() {
    print(id);
    print(room);
    if (room != null) {
      room!.playerActivated(this);
    }
  }

  Map<String, dynamic> toPartialJson() {
    return {'id': id, 'name': name, 'image': image};
  }

  toJson() {
    return {'id': id, 'name': name, 'image': image, 'state': state.name, 'team': team.name, 'inactive': inactive};
  }

  Room? get room {
    return BuzzerServer().rooms.firstWhereOrNull((Room element) => element.players.contains(this));
  }

  BuzzerState get state => _state;

  bool get inactive => _inactive;

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

  set inactive(bool value) {
    _inactive = value;
  }
}
