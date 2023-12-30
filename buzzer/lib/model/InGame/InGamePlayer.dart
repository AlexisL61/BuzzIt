import 'package:buzzer/model/InGame/BuzzerTeam.dart';
import 'package:buzzer/model/Player.dart';

class InGamePlayer extends Player {
  BuzzerTeam team = BuzzerTeam.BLUE;

  InGamePlayer(String name, String image) : super(name, image);

  static InGamePlayer fromJson(json) {
    print(json);
    InGamePlayer player = InGamePlayer(json['name'], json['image']);
    player.team = BuzzerTeamExtension.fromString(json['team']);
    return player;
  }

  toJson() {
    return {
      'name': name,
      'image': image,
      'team': team.name,
    };
  }
}
