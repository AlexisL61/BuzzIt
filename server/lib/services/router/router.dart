import 'dart:async';
import 'dart:convert';

import 'package:server/model/Player.dart';
import 'package:server/services/router/api/routes/AbstractRoute.dart';
import 'package:server/services/router/api/routes/RoomCreatorRoute.dart';
import 'package:server/services/router/api/routes/RoomFinderRoute.dart';
import 'package:server/services/router/api/routes/HealthCheckRoute.dart';
import 'package:server/services/router/api/routes/InfoRoute.dart';
import 'package:server/services/router/ws/WebsocketMessage.dart';
import 'package:server/services/router/ws/messages/in/PlayerDataMessage.dart';
import 'package:server/services/router/ws/messages/out/PlayerDataConfirmationMessage.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_web_socket/shelf_web_socket.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;

class ServerRouter {
  static List<AbstractRoute> availableApiRoutes = [
    RoomCreatorRoute(),
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
    Stream stream = channel.stream.asBroadcastStream();
    Player? player = await waitForPlayerData(stream, channel);
    PlayerDataConfirmationMessage confirmationMessage =
        PlayerDataConfirmationMessage();
    channel.sink.add(jsonEncode(confirmationMessage));
    if (player != null) {
      listenToPlayerActions(stream, player);
    }
  }

  void listenToPlayerActions(Stream stream, Player player) {
    print("LISTENING");
    try {
      stream.listen((event) {
        print(event);
        WebsocketConnectionMessage message =
            WebsocketConnectionMessage.fromJson(jsonDecode(event));
        message.actions.forEach((element) {
          element.activate(player, message);
        });
      }, onDone: () {
        print("Player disconnected");
        player.inactive = true;
      }, onError: (error) {
        player.inactive = true;
        print("Player disconnected");
      });
    } catch (e) {
      player.inactive = true;
      print(e);
    }
  }

  Future<Player?> waitForPlayerData(
      Stream stream, WebSocketChannel channel) async {
    Player? player;
    String event = await stream.first;
    WebsocketConnectionMessage message =
        WebsocketConnectionMessage.fromJson(jsonDecode(event));
    if (message is PlayerDataMessage) {
      return Player(channel, message.name, message.image);
    } else {
      channel.sink.close();
    }
    return player;
  }
}
