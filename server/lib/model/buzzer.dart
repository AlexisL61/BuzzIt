import 'package:web_socket_channel/web_socket_channel.dart';
import 'buzzerState.dart';
import 'package:server/server.dart';
import 'room.dart';
import 'package:collection/collection.dart';
import 'buzzerTeam.dart';
import 'package:server/services/ws/messages/out/BuzzStateMessage.dart';
import 'dart:convert';

class Buzzer {
  WebSocketChannel channel;
  BuzzerState _state;
  BuzzerTeam team = BuzzerTeam.NONE;

  Buzzer(this.channel): _state = BuzzerState.IDLE;

  void buzz() {
    if (room != null) {
      room!.buzzerActivated(this);
    }
  }

  Room? get room {
    return Server().rooms.firstWhereOrNull((Room element) => element.buzzers.contains(this));
  }

  BuzzerState get state => _state;

  set state(BuzzerState value) {
    _state = value;
    BuzzStateMessage message = BuzzStateMessage();
    message.state = value;
    if (room?.activeBuzzerTeam != null){
      message.activeTeam = room!.activeBuzzerTeam!;
    }else{
      message.activeTeam = null;
    }
    channel.sink.add(jsonEncode(message.toJson()));
  }
}