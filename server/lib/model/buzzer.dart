import 'package:web_socket_channel/web_socket_channel.dart';
import 'buzzerState.dart';
import 'package:server/server.dart';
import 'room.dart';
import 'package:collection/collection.dart';

class Buzzer {
  WebSocketChannel channel;
  BuzzerState state;

  Buzzer(this.channel): state = BuzzerState.IDLE;

  void buzz() {
    state = BuzzerState.BUZZED;
  }

  void lock() {
    state = BuzzerState.LOCKED;
  }

  void unlock() {
    state = BuzzerState.IDLE;
  }

  Room? get room {
    return Server().rooms.firstWhereOrNull((Room element) => element.buzzers.contains(this));
  }
}