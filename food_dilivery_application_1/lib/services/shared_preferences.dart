import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static const String userProfileKey = 'user_profile';

  // Method to save user profile to shared preferences
  static Future<void> saveUserProfile(String userProfile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(userProfileKey, userProfile);
  }

  // Method to get user profile from shared preferences
  static Future<String?> getUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userProfileKey);
  }
}
