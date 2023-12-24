import 'package:buzzer/services/ws/WebsocketAction.dart';
import 'package:buzzer/services/ws/messages/BuzzStateMessage.dart';

/// Message websocket
/// 
/// Classe abstraite représentant un message websocket. Le message peut-être envoyé par le serveur ou par le client.
abstract class WebsocketConnectionMessage {

  final String event;
  late dynamic rawData;
  List<WebsocketAction> actions = [];

  WebsocketConnectionMessage(this.event);

  factory WebsocketConnectionMessage.fromJson(Map<String, dynamic> json) {
      WebsocketConnectionMessage message = buildBaseMessage(json["event"]);
      message.rawData = json;
      message.hydrateData(json["data"]);
      return message;
  }

  void hydrateData(dynamic data);
  dynamic toJson();

  static WebsocketConnectionMessage buildBaseMessage(String event){
    switch (event) {
      case BuzzStateMessage.eventId:
        return BuzzStateMessage();
      default:
        throw Exception("Unknown message type");
    }
  }
}