import 'dart:convert';

import 'package:descolar_front/core/constants/user_info.dart';
import 'package:descolar_front/features/auth/data/datasources/user_remote_data_source.dart';
import 'package:descolar_front/features/profil/data/datasources/user_profil_local_data_source.dart';
import 'package:descolar_front/features/profil/data/models/user_profil_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:descolar_front/core/errors/exceptions.dart';
import 'package:descolar_front/features/auth/data/models/user_model.dart';

abstract class UserLocalDataSource {
  Future<void> cacheUser({required UserModel? user});

  void cacheRememberUser({required UserModel? user});

  UserModel? getRememberUser();

  UserModel? signOut();
}

const cachedUser = 'CACHED_USER';
const cachedRememberUser = 'CACHED_REMEMBER_USER';
const cachedUserToken = 'CACHED_USER_TOKEN';

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final SharedPreferences sharedPreferences;
  final UserRemoteDataSourceImpl remote = UserRemoteDataSourceImpl(dio: Dio());

  UserLocalDataSourceImpl({required this.sharedPreferences});

  @override
  UserModel? getRememberUser() {
    final jsonString = sharedPreferences.getString(cachedRememberUser);
    if (jsonString != null) {
      final data = json.decode(jsonString);
      return UserModel.fromJson(json: data);
    }
    return null;
  }

  @override
  void cacheRememberUser({required UserModel? user}) {
    if (user != null) {
      // User remember cache
      sharedPreferences.setString(
        cachedRememberUser,
        json.encode(
          user.toJson(),
        ),
      );
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheUser({required UserModel? user}) async {
    if (user != null) {
      // User cache
      sharedPreferences.setString(
        cachedUser,
        json.encode(
          user.toJson(),
        ),
      );
      // Token cache
      String token = await remote.getToken(uuid: user.uuid);
      sharedPreferences.setString(cachedUserToken, token);
      // UserInfo
      UserInfo.token = token;
      UserInfo.user = user;
      // User Profil
      final UserProfilLocalDataSourceImpl userProfilLocal = UserProfilLocalDataSourceImpl(sharedPreferences: sharedPreferences);
      userProfilLocal.cacheUserProfil(
        userProfil: UserProfilModel(
          uuid: user.uuid,
          firstname: user.firstname,
          lastname: user.lastname,
          username: user.username,
          followers: [],
          following: [],
          pfpPath: null,
        ),
      );
    } else {
      throw CacheException();
    }
  }

  @override
  UserModel? signOut() {
    UserModel? user = UserModel.fromJson(
      json: json.decode(
        sharedPreferences.getString(cachedUser)!,
      ),
    );
    try {
      sharedPreferences.remove(cachedUser);
      sharedPreferences.remove(cachedRememberUser);
      sharedPreferences.remove(cachedUserToken);
    } on Exception {
      throw CacheException();
    }
    return user;
  }
}
