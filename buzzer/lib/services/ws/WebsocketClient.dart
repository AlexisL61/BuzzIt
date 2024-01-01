import 'dart:async';
import 'dart:convert';

import 'package:buzzer/model/InGame/ActivePlayer.dart';
import 'package:buzzer/services/ws/WebsocketMessage.dart';
import 'package:buzzer/services/ws/messages/in/PingMessage.dart';
import 'package:buzzer/services/ws/messages/in/PlayerDataConfirmationMessage.dart';
import 'package:buzzer/services/ws/messages/out/PlayerDataMessage.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebsocketClient {
  static final WebsocketClient _singleton = WebsocketClient._internal();
  factory WebsocketClient() {
    return _singleton;
  }
  WebsocketClient._internal();

  late WebSocketChannel _socket;
  late Stream stream;
  bool _isConnected = false;
  bool get isConnected => _isConnected;

  Future<void> connect(ActivePlayer player, String wsServer) async {
    try {
      _socket = WebSocketChannel.connect(Uri.parse(wsServer));
      stream = _socket.stream.asBroadcastStream();
      await _socket.ready;
      bool success = await sendPlayerData(player, _socket);
      if (!success) {
        _socket.sink.close();
        throw Exception("Could not connect to server");
      }
      _isConnected = true;
      player.notifyListeners();
      _checkPingMessages(player);
      stream.listen((event) {
        onMessage(player, event);
      }, onError: (e) {
        emitOnError(player);
      }, onDone: () {
        emitOnError(player);
      });
    } catch (e) {
      emitOnError(player);
      print(e);
    }
  }

  void emitOnError(ActivePlayer player) {
    _isConnected = false;
    _socket.sink.close(1001, "Connection closed");
    player.notifyListeners();
  }

  Future<bool> sendPlayerData(ActivePlayer player, WebSocketChannel socket) async {
    PlayerDataMessage playerDataMessage = PlayerDataMessage();
    playerDataMessage.name = player.name;
    playerDataMessage.image = player.image;
    send(playerDataMessage);

    String event = await stream.first;
    WebsocketConnectionMessage message = WebsocketConnectionMessage.fromJson(jsonDecode(event));
    if (message.event == PlayerDataConfirmationMessage.eventId) {
      return true;
    } else {
      socket.sink.close();
      return false;
    }
  }

  void send(WebsocketConnectionMessage message) {
    _socket.sink.add(jsonEncode(message.toJson()));
  }

  void onMessage(ActivePlayer buzzer, dynamic event) {
    WebsocketConnectionMessage message = WebsocketConnectionMessage.fromJson(jsonDecode(event));
    print(event);
    for (var element in message.actions) {
      element.activate(buzzer, message);
    }
  }

  Future<T> waitMessage<T>() async {
    String message = await stream.firstWhere((event) {
      WebsocketConnectionMessage message = WebsocketConnectionMessage.fromJson(jsonDecode(event));
      if (message is T) {
        return true;
      } else {
        return false;
      }
    });
    T convertedMessage = WebsocketConnectionMessage.fromJson(jsonDecode(message)) as T;
    return convertedMessage;
  }

  void _checkPingMessages(ActivePlayer player) async {
    while (_isConnected) {
      bool istimeout = false;
      Future timeout = Future.delayed(const Duration(seconds: 10));
      timeout.then((value) => istimeout = true);
      await Future.any([timeout, waitMessage<PingMessage>()]);
      if (istimeout) {
        _isConnected = false;
        _socket.sink.close(1001, "Connection closed");
        player.notifyListeners();
      }
    }
  }
}
