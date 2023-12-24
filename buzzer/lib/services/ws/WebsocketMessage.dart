import 'package:buzzer/services/ws/WebsocketAction.dart';

/// Message websocket
/// 
/// Classe abstraite représentant un message websocket. Le message peut-être envoyé par le serveur ou par le client.
abstract class WebsocketConnectionMessage {
  static const Map<String, dynamic> availableMessageType = {
    
  };

  final String event;
  late dynamic rawData;
  List<WebsocketAction> actions = [];

  WebsocketConnectionMessage(this.event);

  factory WebsocketConnectionMessage.fromJson(Map<String, dynamic> json) {
    if (availableMessageType.containsKey(json["event"])) {
      WebsocketConnectionMessage message =
          availableMessageType[json["event"]]!(json["event"]);
      message.rawData = json;
      message.hydrateData(json["data"]);
      return message;
    } else {
      throw Exception("Unknown message type");
    }
  }

  void hydrateData(dynamic data);
  dynamic toJson();
}