import 'dart:convert';

import 'package:server/model/Player.dart';
import 'package:server/services/router/api/routes/AbstractRoute.dart';
import 'package:server/services/router/api/routes/GameFinderRoute.dart';
import 'package:server/services/router/api/routes/HealthCheckRoute.dart';
import 'package:server/services/router/api/routes/InfoRoute.dart';
import 'package:server/services/router/ws/WebsocketMessage.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_web_socket/shelf_web_socket.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;

class ServerRouter {
  static List<AbstractRoute> availableApiRoutes = [
    RoomFinderRoute(),
    HealthcheckRoute(),
    InfoRoute()
  ];

  void startRouter() {
    Router app = Router();

    availableApiRoutes.forEach((element) {
      element.importRoute(app);
    });

    app.get('/ws', webSocketHandler(onNewWsConnection));

    shelf_io.serve(app, "0.0.0.0", 8080, shared: true);
  }

  void onNewWsConnection(WebSocketChannel channel) async {
    await channel.ready;
    Player buzzer = Player(channel, "Alexis", "");
    channel.stream.listen((event) {
      WebsocketConnectionMessage message =
          WebsocketConnectionMessage.fromJson(jsonDecode(event));
      message.actions.forEach((element) {
        element.activate(buzzer, message);
      });
    });
  }
}
