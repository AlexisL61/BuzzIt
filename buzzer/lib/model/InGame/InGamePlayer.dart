import 'package:buzzer/model/InGame/BuzzerTeam.dart';
import 'package:buzzer/model/Player.dart';

class InGamePlayer extends Player {
  String id;
  bool inactive = false;
  BuzzerTeam team = BuzzerTeam.BLUE;

  InGamePlayer(this.id, String name, String image) : super(name, image);

  static InGamePlayer fromJson(json) {
    InGamePlayer player = InGamePlayer(json["id"], json['name'], json['image']);
    player.team = BuzzerTeamExtension.fromString(json['team']);
    player.inactive = json['inactive'];
    return player;
  }

  toJson() {
    return {
      'name': name,
      'image': image,
      'team': team.name,
      'id': id,
      'inactive': inactive
    };
  }

  void updateFromUpdateData(Map<String, dynamic> newPlayer) {
    this.name = newPlayer['name'];
    this.image = newPlayer['image'];
    this.team = BuzzerTeamExtension.fromString(newPlayer['team']);
    this.inactive = newPlayer['inactive'];
  }
}
