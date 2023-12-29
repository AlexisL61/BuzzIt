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
}