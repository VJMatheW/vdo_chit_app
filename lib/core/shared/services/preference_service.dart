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
		SharedPreferences pref = await SharedPreferences.getInstance();
		return pref.get(key);
	}

	@override
	Future<void> setBool(String key, bool value) async {
		SharedPreferences pref = await SharedPreferences.getInstance();
		return pref.setBool(key, value);
	}

	@override
	setInt(String key, int value) async {
		SharedPreferences pref = await SharedPreferences.getInstance();
		return pref.setInt(key, value);
	}

	@override
	setString(String key, String value) async {
		SharedPreferences pref = await SharedPreferences.getInstance();
		return pref.setString(key, value);
	}
}
