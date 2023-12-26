import 'package:buzzer/model/InGame/BuzzerTeam.dart';
import 'package:buzzer/model/Player.dart';

class InGamePlayer extends Player {
  BuzzerTeam team = BuzzerTeam.NONE;

  InGamePlayer(String name, String image) : super(name, image);
}