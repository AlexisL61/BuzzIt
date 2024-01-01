import 'dart:convert';

import 'package:server/model/Room.dart';
import 'package:server/server.dart';
import 'package:server/services/router/api/routes/AbstractRoute.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class RoomCreatorRoute extends AbstractRoute {
  static const String route = '/room/create';

  @override
  void importRoute(Router router) {
    router.post(route, (Request request) {
      return Response.ok(jsonEncode(createRoom()));
    });
  }

  Map<String, dynamic> createRoom() {
    Room roomFound = BuzzerServer().getRandomRoom();
    return {
      "room": roomFound.toPartialJson(),
      "status": "OK",
      "token": roomFound.generateConnectionToken().token
    };
  }
}
