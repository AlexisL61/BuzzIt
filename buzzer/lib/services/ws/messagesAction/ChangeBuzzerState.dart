import 'package:audioplayers/audioplayers.dart';
import 'package:buzzer/model/InGame/ActivePlayer.dart';
import 'package:buzzer/model/InGame/BuzzerState.dart';
import 'package:buzzer/services/ws/WebsocketAction.dart';
import 'package:buzzer/services/ws/WebsocketMessage.dart';
import 'package:buzzer/services/ws/messages/in/BuzzStateMessage.dart';

class ChangeBuzzerStateAction extends WebsocketAction {
  @override
  void activate(ActivePlayer buzzer, WebsocketConnectionMessage message) {
    BuzzStateMessage buzzStateMessage = message as BuzzStateMessage;
    buzzer.state = buzzStateMessage.state;
    if (buzzer.state == BuzzerState.LOCKED_BY_ENNEMY) {
      buzzer.ennemyTeam = buzzStateMessage.activeTeam!;
    }
    buzzer.notifyListeners();

    if (buzzer.state == BuzzerState.BUZZED) {
      final player = AudioPlayer();
      player.play(AssetSource('sounds/buzz.mp3'));
    }
  }
}
