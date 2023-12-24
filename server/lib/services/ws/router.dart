import 'dart:convert';

import 'package:server/model/buzzer.dart';
import 'package:server/services/ws/WebsocketMessage.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_web_socket/shelf_web_socket.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;

class WsRouter {
  void startRouter() {
    Router wsApp = Router();

    wsApp.get('/ws', webSocketHandler(onNewWsConnection));

    shelf_io.serve(wsApp, "0.0.0.0", 8080, shared: true);
  }

  void onNewWsConnection(WebSocketChannel channel) async {
    await channel.ready;
    Buzzer buzzer = Buzzer(channel);
    channel.stream.listen((event) {
      print("MESSAGE RECEIVED " + event);
      WebsocketConnectionMessage message =
          WebsocketConnectionMessage.fromJson(jsonDecode(event));
      message.actions.forEach((element) {
        element.activate(buzzer, message);
      });
    });
  }
}
