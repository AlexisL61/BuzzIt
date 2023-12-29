import 'dart:convert';

import 'package:server/model/Room.dart';
import 'package:server/server.dart';
import 'package:server/services/router/api/routes/AbstractRoute.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class RoomFinderRoute extends AbstractRoute {
  static const String route = '/room/<id>';

  void importRoute(Router router) {
    router.get(route, (Request request, String id) {
      return Response.ok(jsonEncode(findRoom(id)));
    });
  }

  Map<String, dynamic> findRoom(String id) {
    Room? roomFound = BuzzerServer().getRoomById(id);
    if (roomFound != null) {
      return roomFound.toPartialJson();
    } else {
      return {'status': 'NOT_FOUND', 'message': 'Room not found'};
    }
  }
}
