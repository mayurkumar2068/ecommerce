import 'package:shared_preferences/shared_preferences.dart';

class DataBaseHelper {
  static const String _loginStatusKey = 'isLoggedIn'; // Key to store login status

  Future<SharedPreferences> _getInstance() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref;
  }

  Future<bool> setUserValue(String userKey, String userValue) async {
    SharedPreferences pref = await _getInstance();
    return await pref.setString(userKey, userValue);
  }

  Future<String?> getUserValue(String key) async {
    SharedPreferences pref = await _getInstance();
    return pref.getString(key);
  }

  Future<void> saveUserData(String key, String value) async {
    await setUserValue(key, value);
    await setLoginStatus(true);
  }

  Future<String?> loadUserData(String key) async {
    return await getUserValue(key);
  }

  Future<void> setLoginStatus(bool isLoggedIn) async {
    SharedPreferences pref = await _getInstance();
    await pref.setBool(_loginStatusKey, isLoggedIn);
  }

  Future<bool?> getLoginStatus() async {
    SharedPreferences pref = await _getInstance();
    return pref.getBool(_loginStatusKey);
  }

  Future<bool> isUserLoggedIn() async {
    bool? loggedIn = await getLoginStatus();
    return loggedIn ?? false;
  }
}
