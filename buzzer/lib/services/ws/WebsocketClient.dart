import 'dart:convert';

import 'package:buzzer/model/buzzer.dart';
import 'package:buzzer/services/ws/WebsocketMessage.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebsocketClient {
  static final WebsocketClient _singleton = WebsocketClient._internal();
  factory WebsocketClient() {
    return _singleton;
  }
  WebsocketClient._internal();

  late WebSocketChannel _socket;
  bool _isConnected = false;
  bool get isConnected => _isConnected;

  Future<void> connect(Buzzer buzzer) async {
    const HOST = String.fromEnvironment("HOST");
    const HOST_PORT = String.fromEnvironment("HOST_PORT");
    try {
      _socket = WebSocketChannel.connect(
          Uri.parse('ws://' + HOST + ':' + HOST_PORT + '/ws'));
      await _socket.ready;
      _isConnected = true;
      buzzer.notifyListeners();
      _socket.stream.listen((event) {
        onMessage(buzzer, event);
      }, onDone: () {
        _isConnected = false;
        buzzer.notifyListeners();
      }, onError: (e) {
        _isConnected = false;
        buzzer.notifyListeners();
      });
    } catch (e) {
      _isConnected = false;
      buzzer.notifyListeners();
      print(e);
    }
  }

  void send(WebsocketConnectionMessage message) {
    _socket.sink.add(jsonEncode(message.toJson()));
  }

  void onMessage(Buzzer buzzer, dynamic event) {
    print("MESSAGE RECEIVED " + event);
    WebsocketConnectionMessage message =
        WebsocketConnectionMessage.fromJson(jsonDecode(event));
    message.actions.forEach((element) {
      element.activate(buzzer, message);
    });
  }
}
