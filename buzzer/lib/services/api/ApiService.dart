import 'dart:convert';
import 'dart:io';

import 'package:buzzer/model/ServerInfo.dart';
import 'package:buzzer/model/Room.dart';
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

  Future<ServerInfo> getServerInfo([String? serverUrlOverride]) async {
    Map<String, dynamic> body = await get("/info", serverUrlOverride);
    return ServerInfo.fromJson(body);
  }

  Future<Room?> getRoomData(String roomId) async {
    Map<String, dynamic> body = await get("/room/join/$roomId");
    if (body['status'] == 'OK') {
      return Room.fromJson(body['room'], body['token']);
    } else {
      return null;
    }
  }

  Future<Room?> createRoom() async {
    Map<String, dynamic> body = await post("/room/create", {});
    if (body['status'] == 'OK') {
      return Room.fromJson(body['room'], body['token']);
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>> get(String path,
      [String? serverUrlOverride]) async {
    try {
      print('GET $serverUrl$path');
      print(serverUrlOverride);
      Response res =
          await http.get(Uri.parse((serverUrlOverride ?? serverUrl) + path));
      String body = res.body;
      return jsonDecode(body);
    } catch (e) {
      print(e);
      throw HttpError("Error while fetching data from server");
    }
  }

  Future<Map<String, dynamic>> post(
      String path, Map<String, dynamic> body) async {
    try {
      print('POST $serverUrl$path');
      Response res = await http.post(Uri.parse(serverUrl + path),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(body));
      String resBody = res.body;
      return jsonDecode(resBody);
    } catch (e) {
      print(e);
      throw HttpError("Error while fetching data from server");
    }
  }
}
