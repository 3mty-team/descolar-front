import 'dart:convert';

import 'package:descolar_front/core/constants/cached_constants.dart';
import 'package:descolar_front/features/auth/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:descolar_front/features/auth/business/entities/user_entity.dart';

class UserInfo {
  static String token = '';
  static UserEntity user = UserModel(uuid: '', email: '', lastname: '', firstname: '', dateOfBirth: DateTime.now(), username: '', password: '');
  // UserProfil

  static void setUserInfo() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString(CachedConstants.cachedUserTokenKey)!;
    Map<String, dynamic> userJson = jsonDecode(sharedPreferences.getString(CachedConstants.cachedUser)!);
    user = UserModel.fromJson(json: userJson);
  }
}
