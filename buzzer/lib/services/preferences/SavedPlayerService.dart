import 'dart:math';

import 'package:buzzer/model/Player.dart';
import 'package:buzzer/services/preferences/UserPreferencesService.dart';

class SavedPlayerService {
  static Player savedPlayer = Player("Player", "Player");

  static Future<void> init() async {
    savedPlayer.name = await UserPreferencesService().username;
    savedPlayer.image = await UserPreferencesService().avatar;
  }

  static Future<void> savePlayer(Player player) async {
    await UserPreferencesService().setUsername(player.name);
    await UserPreferencesService().setAvatar(player.image);
    savedPlayer = player;
  }

  static Future<void> randomAvatar() async {
    await UserPreferencesService().setAvatar(Random().nextInt(10000).toString());
    savedPlayer.image = await UserPreferencesService().avatar;
  }
}
