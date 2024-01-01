import 'dart:convert';

import 'package:server/services/router/api/routes/AbstractRoute.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class InfoRoute extends AbstractRoute {
  static const String info = '/info';

  @override
  void importRoute(Router router) {
    router.get(info, (Request request) {
      return Response.ok(jsonEncode(jsonInfoData()));
    });
  }

  Map<String, dynamic> jsonInfoData() {
    return {
      'status': 'OK',
      'wsUrl': 'ws://10.0.2.2:8080/ws',
      'apiUrl': 'http://10.0.2.2:8080/'
    };
  }
}
