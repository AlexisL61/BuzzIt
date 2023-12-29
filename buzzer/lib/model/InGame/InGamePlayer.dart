import 'package:buzzer/model/InGame/BuzzerTeam.dart';
import 'package:buzzer/model/Player.dart';

class InGamePlayer extends Player {
  BuzzerTeam team = BuzzerTeam.BLUE;

  InGamePlayer(String name, String image) : super(name, image);
}