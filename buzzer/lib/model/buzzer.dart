import 'package:buzzer/services/ws/WebsocketClient.dart';
import 'package:buzzer/services/ws/messages/BuzzMessage.dart';
import 'package:buzzer/services/ws/messages/RoomChosenMessage.dart';
import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'buzzerState.dart';
import 'package:collection/collection.dart';

class Buzzer {
  BuzzerState state;
  WebsocketClient client = WebsocketClient();
  List<Function> _listeners = [];

  Buzzer(): state = BuzzerState.IDLE;

  Future<void> init() async{
    await client.connect(this);
    RoomChosenMessage roomChosenMessage = RoomChosenMessage();
    roomChosenMessage.roomId = "1";
    client.send(roomChosenMessage);
  }

  void buzz() {
    client.send(BuzzMessage());
  }

  void addListener(Function listener) {
    _listeners.add(listener);
  }

  void removeListener(Function listener) {
    _listeners.remove(listener);
  }

  void notifyListeners() {
    _listeners.forEach((element) {
      element();
    });
  }
}