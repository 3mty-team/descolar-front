import 'package:shared_preferences/shared_preferences.dart';

class UserInfo {
  static String token = '';
  static String user = '';

  static void setUserInfo() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString('CACHED_USER_TOKEN')!;
    user = sharedPreferences.getString('CACHED_USER')!;
  }
}
