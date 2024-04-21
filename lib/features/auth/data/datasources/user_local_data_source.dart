import 'dart:convert';

import 'package:descolar_front/core/params/params.dart';
import 'package:descolar_front/features/auth/data/datasources/user_remote_data_source.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:descolar_front/core/errors/exceptions.dart';
import 'package:descolar_front/features/auth/data/models/user_model.dart';

abstract class UserLocalDataSource {
  Future<void> cacheUser({required UserModel? user});
  Future<void> cacheRememberUser({required UserModel? user});
  UserModel? getRememberUser();
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
  Future<void> cacheRememberUser({required UserModel? user}) async {
    if (user != null) {
      sharedPreferences.setString(
        cachedRememberUser,
        json.encode(
          user.toJson(),
        ),
      );
      print(sharedPreferences.getString(cachedUser));
      print(sharedPreferences.getString(cachedRememberUser));
      print(sharedPreferences.getString(cachedUserToken));
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
      sharedPreferences.setString(cachedUserToken, await remote.getToken(uuid: user.uuid));
      print(sharedPreferences.getString(cachedUser));
      print(sharedPreferences.getString(cachedRememberUser));
      print(sharedPreferences.getString(cachedUserToken));
    } else {
      throw CacheException();
    }
  }
}
