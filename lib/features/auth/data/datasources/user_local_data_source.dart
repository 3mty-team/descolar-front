import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:descolar_front/core/errors/exceptions.dart';
import 'package:descolar_front/features/auth/data/models/user_model.dart';

// TODO : "remember me"

abstract class UserLocalDataSource {
  Future<void> cacheUser({required UserModel? templateToCache});
  Future<UserModel> getLastUser();
}

const cachedUser = 'CACHED_TEMPLATE';

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final SharedPreferences sharedPreferences;

  UserLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<UserModel> getLastUser() {
    final jsonString = sharedPreferences.getString(cachedUser);

    if (jsonString != null) {
      return Future.value(
          UserModel.fromJson(json: json.decode(jsonString)),);
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
}
