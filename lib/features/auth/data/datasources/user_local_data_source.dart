import 'dart:convert';

import 'package:descolar_front/core/params/params.dart';
import 'package:descolar_front/features/auth/data/datasources/user_remote_data_source.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:descolar_front/core/errors/exceptions.dart';
import 'package:descolar_front/features/auth/data/models/user_model.dart';

// TODO : "remember me"

abstract class UserLocalDataSource {
  Future<void> cacheUser({required UserModel? user});

  UserModel? getRememberUser();
}

const cachedUser = 'CACHED_USER';

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final SharedPreferences sharedPreferences;
  final UserRemoteDataSourceImpl remote = UserRemoteDataSourceImpl(dio: Dio());

  UserLocalDataSourceImpl({required this.sharedPreferences});

  @override
  UserModel? getRememberUser() {
    final jsonString = sharedPreferences.getString(cachedUser);

    if (jsonString != null) {
      final data = json.decode(jsonString);
      return UserModel.fromJson(json: data);
    }

    return null;
  }

  @override
  Future<void> cacheUser({required UserModel? user}) async {
    if (user != null) {
      sharedPreferences.setString(
        cachedUser,
        json.encode(
          user.toJson(),
        ),
      );
      print(sharedPreferences.getString(cachedUser));
    } else {
      throw CacheException();
    }
  }
}
