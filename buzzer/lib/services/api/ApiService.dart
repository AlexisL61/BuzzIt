import 'dart:convert';
import 'dart:io';

import 'package:buzzer/model/ServerInfo.dart';
import 'package:buzzer/model/room.dart';
import 'package:buzzer/services/api/HttpError.dart';
import 'package:buzzer/services/preferences/UserPreferencesService.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiService {
  late String serverUrl;
  late HttpClient httpClient;

  factory ApiService() => _instance;

  static final ApiService _instance = ApiService._internal();

  ApiService._internal();

  Future<void> init() async {
    serverUrl = await UserPreferencesService().masterServerURL;
    httpClient = HttpClient();
  }

  Future<ServerInfo> getServerInfo() async {
    Map<String, dynamic> body = await get("/info");
    return ServerInfo.fromJson(body);
  }

  Future<Room?> getRoomData(String roomId) async {
    Map<String, dynamic> body = await get("/room/$roomId");
    if (body['status'] == 'OK') {
      return Room.fromJson(body['data']);
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>> get(String path) async {
    try {
      print('GET $serverUrl$path');
      Response res =
          await http.get(Uri.parse(serverUrl + path));
      String body = res.body;
      return jsonDecode(body);
    } catch (e) {
      print(e);
      throw HttpError("Error while fetching data from server");
    }
  }
}