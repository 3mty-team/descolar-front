import 'dart:convert';

import 'package:descolar_front/core/constants/cached_constants.dart';
import 'package:descolar_front/features/auth/data/models/user_model.dart';
import 'package:descolar_front/features/profil/data/models/user_profil_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:descolar_front/features/auth/business/entities/user_entity.dart';

class UserInfo {
  static String token = '';
  static UserEntity user = UserModel(uuid: '', email: '', lastname: '', firstname: '', dateOfBirth: DateTime.now(), username: '', password: '');
  static UserProfilModel userProfil = const UserProfilModel(uuid: '', firstname: '', lastname: '', username: '', followers: [], following: [], pfpPath: '', bannerPath: '');

  // UserProfil

  static void setUserInfo() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString(CachedConstants.cachedUserTokenKey)!;
    Map<String, dynamic> userJson = jsonDecode(sharedPreferences.getString(CachedConstants.cachedUser)!);
    user = UserModel.fromJson(json: userJson);
    Map<String, dynamic> userProfilJson = jsonDecode(sharedPreferences.getString(CachedConstants.cachedUserProfil)!);
    userProfil = UserProfilModel.fromJson(json: userProfilJson);
  }
}
