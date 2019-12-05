import 'package:shared_preferences/shared_preferences.dart';

class PreferenceService{
  static PreferenceService _instance;
  static SharedPreferences _preferences;

  static const String dateKey = 'date';

  static Future<PreferenceService> getInstance() async {
    if (_instance == null) {
      _instance = PreferenceService();
    }
    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }
    return _instance;
  }

  set date(String date) => _preferences.setString(dateKey, date);
  String get date => _preferences.getString(dateKey);
}