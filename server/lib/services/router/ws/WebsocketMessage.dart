import 'package:server/services/router/ws/WebsocketAction.dart';
import 'package:server/services/router/ws/messages/in/BuzzMessage.dart';
import 'package:server/services/router/ws/messages/in/ChangeTeamRequestMessage.dart';
import 'package:server/services/router/ws/messages/in/PlayerDataMessage.dart';
import 'package:server/services/router/ws/messages/in/RoomJoinRequestMessage.dart';
import 'package:server/services/router/ws/messages/in/UnBuzzMessage.dart';

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

  static WebsocketConnectionMessage buildBaseMessage(String event) {
    switch (event) {
      case RoomJoinRequestMessage.eventId:
        return RoomJoinRequestMessage();
      case BuzzMessage.eventId:
        return BuzzMessage();
      case UnBuzzMessage.eventId:
        return UnBuzzMessage();
      case ChangeTeamRequestMessage.eventId:
        return ChangeTeamRequestMessage();
      case PlayerDataMessage.eventId:
        return PlayerDataMessage();
      default:
        throw Exception("Unknown message type");
    }
  }
}
