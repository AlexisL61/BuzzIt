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
    String? masterServerURI = _preferences.getString("master_server");
    if (masterServerURI == null) {
      masterServerURI = BuzzerConfig.API_URL;
      _preferences.setString("master_server", masterServerURI);
    }
    return masterServerURI;
  }

  Future<String> get username async {
    String? username = _preferences.getString("username");
    if (username == null) {
      username = "Player";
      _preferences.setString("username", username);
    }
    return username;
  }

  Future<String?> get latestRoomCode async {
    String? roomCode = _preferences.getString("room_code");
    return roomCode;
  }

  Future<String?> get reconnectionToken async {
    String? reconnectionToken = _preferences.getString("reconnection_token");
    return reconnectionToken;
  }

  Future<String> get avatar async {
    String? avatar = _preferences.getString("avatar");
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

  Future<void> setLatestRoomCode(String roomCode) async {
    await _preferences.setString("room_code", roomCode);
  }

  Future<void> setReconnectionToken(String reconnectionToken) async {
    await _preferences.setString("reconnection_token", reconnectionToken);
  }
}