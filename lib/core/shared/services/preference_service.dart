import 'package:shared_preferences/shared_preferences.dart';

abstract class PreferenceInterface {
  getPreference(String key);
  setBool(String key, bool value);
  setInt(String key, int value);
  setString(String key, String value);
}

class PreferenceService implements PreferenceInterface {
  SharedPreferences _preferences;

  @override
  Future<dynamic> getPreference(String key) async {
    // TODO: implement getPreference
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.get(key);
  }

  @override
  Future<void> setBool(String key, bool value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setBool(key, value);
  }

  @override
  setInt(String key, int value) {
    // TODO: implement setInt
    throw UnimplementedError();
  }

  @override
  setString(String key, String value) {
    // TODO: implement setString
    throw UnimplementedError();
  }
}
