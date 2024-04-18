import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:descolar_front/core/errors/exceptions.dart';
import 'package:descolar_front/features/auth/data/models/user_model.dart';

// TODO : "remember me"

abstract class UserLocalDataSource {
  Future<void> cacheUser({required UserModel? templateToCache});

  Future<void> cacheToken({required String token});

  Future<UserModel> getLastUser();

  Future<String?> getActiveToken();
}

const cachedUser = 'CACHED_USER';
const cachedToken = 'CACHED_TOKEN';

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final SharedPreferences sharedPreferences;

  UserLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<UserModel> getLastUser() {
    final jsonString = sharedPreferences.getString(cachedUser);
    if (jsonString != null) {
      return Future.value(
        UserModel.fromJson(json: json.decode(jsonString)),
      );
    } else {
      throw CacheException();
    }
  }

  @override
  Future<String?> getActiveToken() async {
    final token = sharedPreferences.getString(cachedToken);
    if (token != null) {
      return token;
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheUser({required UserModel? templateToCache}) async {
    if (templateToCache != null) {
      sharedPreferences.setString(
        cachedUser,
        json.encode(
          templateToCache.toJson(),
        ),
      );
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheToken({required String token}) async {
    sharedPreferences.setString(cachedToken, token);
  }
}
