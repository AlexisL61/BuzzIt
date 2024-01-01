import 'dart:convert';

import 'package:server/services/router/api/routes/AbstractRoute.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class HealthcheckRoute extends AbstractRoute {
  static const String healthcheck = '/healthcheck';

  @override
  void importRoute(Router router){
    router.get(healthcheck, (Request request) {
      return Response.ok(jsonEncode(jsonHealthcheckData()));
    });
  }

  Map<String, dynamic> jsonHealthcheckData(){
    return {
      'status': 'OK'
    };
  }
}