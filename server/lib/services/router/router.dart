import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:server/model/Player.dart';
import 'package:server/services/router/api/routes/AbstractRoute.dart';
import 'package:server/services/router/api/routes/RoomCreatorRoute.dart';
import 'package:server/services/router/api/routes/RoomFinderRoute.dart';
import 'package:server/services/router/api/routes/HealthCheckRoute.dart';
import 'package:server/services/router/api/routes/InfoRoute.dart';
import 'package:server/services/router/ws/WebsocketMessage.dart';
import 'package:server/services/router/ws/messages/in/PlayerDataMessage.dart';
import 'package:server/services/router/ws/messages/in/PongMessage.dart';
import 'package:server/services/router/ws/messages/out/PingMessage.dart';
import 'package:server/services/router/ws/messages/out/PlayerDataConfirmationMessage.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_web_socket/shelf_web_socket.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_plus/shelf_plus.dart';

class ServerRouter {
  static List<AbstractRoute> availableApiRoutes = [
    RoomCreatorRoute(),
    RoomFinderRoute(),
    HealthcheckRoute(),
    InfoRoute()
  ];

  final serverCorsHeaders = {
    ACCESS_CONTROL_ALLOW_ORIGIN:
        !Platform.environment.containsKey("CORS_ORIGIN") ? "" : Platform.environment["CORS_ORIGIN"]!, 
    'Content-Type': 'application/json'
  };

  void startRouter() {    
    RouterPlus app = Router().plus;

    app.use(corsHeaders(headers: serverCorsHeaders));

    for (var element in availableApiRoutes) {
      element.importRoute(app);
    }

    app.get('/ws', webSocketHandler(onNewWsConnection));

    // Starting static file handler
    if (Platform.environment.containsKey("STATIC_FILES_PATH")) {
      app.mount('/app', createStaticHandler(Platform.environment["STATIC_FILES_PATH"]!, defaultDocument: 'index.html'));
    }

    app.all('/<ignored|.*>', (Request request) {
      if (request.method == 'OPTIONS') return Response.ok(null, headers: serverCorsHeaders);
      return Response.notFound('Not found');
    });

    shelf_io.serve(app, "0.0.0.0", int.parse(Platform.environment["SERVER_PORT"]!), shared: true);
  }

  void onNewWsConnection(WebSocketChannel channel) async {
    await channel.ready;
    Stream stream = channel.stream.asBroadcastStream();
    Player? player = await waitForPlayerData(stream, channel);
    PlayerDataConfirmationMessage confirmationMessage = PlayerDataConfirmationMessage();
    channel.sink.add(jsonEncode(confirmationMessage));
    if (player != null) {
      _emitPingMessages(player, channel, stream);
      listenToPlayerActions(stream, player);
    }
  }

  void listenToPlayerActions(Stream stream, Player player) {
    try {
      stream.listen((event) {
        print(event);
        WebsocketConnectionMessage message = WebsocketConnectionMessage.fromJson(jsonDecode(event));
        for (var element in message.actions) {
          element.activate(player, message);
        }
      }, onDone: () {
        player.inactive = true;
      }, onError: (error) {
        player.inactive = true;
      });
    } catch (e) {
      player.inactive = true;
      print(e);
    }
  }

  Future<Player?> waitForPlayerData(Stream stream, WebSocketChannel channel) async {
    Player? player;
    String event = await stream.first;
    WebsocketConnectionMessage message = WebsocketConnectionMessage.fromJson(jsonDecode(event));
    if (message is PlayerDataMessage) {
      return Player(channel, message.name, message.image);
    } else {
      channel.sink.close();
    }
    return player;
  }

  Future<T> waitMessage<T>(Stream stream) async {
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

  void _emitPingMessages(Player player, WebSocketChannel channel, Stream stream) async {
    while (player.inactive == false) {
      await Future.delayed(Duration(seconds: 3));
      PingMessage pingMessage = PingMessage();
      channel.sink.add(jsonEncode(pingMessage.toJson()));

      bool istimeout = false;
      Future timeout = Future.delayed(Duration(seconds: 10));
      timeout.then((value) => istimeout = true);
      await Future.any([timeout, waitMessage<PongMessage>(stream)]);
      if (istimeout) {
        player.inactive = true;
        channel.sink.close(1001, "Connection closed");
      }
    }
  }
}
