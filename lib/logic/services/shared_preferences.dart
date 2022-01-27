import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceFuntions {
  static String userLoggedInKey = 'ISLOGGEDIN';
  static String userNameKey = 'USERNAMEKEY';
  static String userEmailKey = 'USEREMAILKEY';

  // Save data to Shared Preferences

  static Future<bool> saveUserLoggedInSharedPreferences(
    bool isUserLoggedIn,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(userLoggedInKey, isUserLoggedIn);
  }

  static Future<bool> saveUserNameSharedPreferences(String userName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userNameKey, userName);
  }

  static Future<bool> saveUserEmailSharedPreferences(String userEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userEmailKey, userEmail);
  }

  // Get data from Shared Preferences

  static Future<bool?> getUserLoggedInSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(userLoggedInKey);
  }

  static Future<String?> getUserNameSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userNameKey);
  }

  static Future<String?> getUserEmailSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userEmailKey);
  }
}
