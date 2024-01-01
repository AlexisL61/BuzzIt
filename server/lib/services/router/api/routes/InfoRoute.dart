import 'dart:convert';
import 'dart:io';

import 'package:server/services/router/api/routes/AbstractRoute.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class InfoRoute extends AbstractRoute {
  static const String info = '/info';

  @override
  void importRoute(Router router) {
    router.get(info, (Request request) async {
      return Response.ok(jsonEncode(await jsonInfoData()));
    });
  }

  Future<Map<String, dynamic>> jsonInfoData() async{
    return {
      'status': 'OK',
      'wsUrl': buildWsLink(),
      'apiUrl': buildApiLink(),
      'version': '0.1.0'
    };
  }

  String buildWsLink(){
    if (Platform.environment['TLS'] == 'true') {
      return 'wss://${Platform.environment['SERVER_URL']}/ws';
    } else {
      return 'ws://${Platform.environment['SERVER_URL']}/ws';
    }
  }

  String buildApiLink(){
    if (Platform.environment['TLS'] == 'true') {
      return 'https://${Platform.environment['SERVER_URL']}/';
    } else {
      return 'http://${Platform.environment['SERVER_URL']}/';
    }
  }
}
