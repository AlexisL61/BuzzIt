import 'package:buzzer/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferencesService {
  late SharedPreferences _preferences;

  factory UserPreferencesService() => _instance;

  static final UserPreferencesService _instance =
      UserPreferencesService._internal();

  UserPreferencesService._internal();

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future<String> get masterServerURL async {
    String? masterServerURI = await _preferences.getString("master_server");
    if (masterServerURI == null) {
      masterServerURI = BuzzerConfig.API_URL;
      _preferences.setString("master_server", masterServerURI);
    }
    return masterServerURI;
  }

  Future<String> get username async {
    String? username = await _preferences.getString("username");
    if (username == null) {
      username = "Player";
      _preferences.setString("username", username);
    }
    return username;
  }

  Future<String> get avatar async {
    String? avatar = await _preferences.getString("avatar");
    if (avatar == null) {
      avatar = await username;
      _preferences.setString("avatar", avatar);
    }
    return avatar;
  }

  Future<void> setUsername(String username) async {
    await _preferences.setString("username", username);
  }

  Future<void> setAvatar(String avatar) async {
    await _preferences.setString("avatar", avatar);
  }

  Future<void> setMasterServerURL(String url) async {
    await _preferences.setString("master_server", url);
  }
}