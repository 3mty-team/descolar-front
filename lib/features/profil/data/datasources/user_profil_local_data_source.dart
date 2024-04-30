import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:descolar_front/core/errors/exceptions.dart';
import 'package:descolar_front/features/profil/data/models/user_profil_model.dart';

abstract class UserProfilLocalDataSource {
  Future<void> cacheUserProfil({required UserProfilModel? userProfil});

  Future<UserProfilModel> getMyUserProfil();
}

const cachedMyUserProfil = 'CACHED_MY_USER_PROFIL';

class UserProfilLocalDataSourceImpl implements UserProfilLocalDataSource {
  final SharedPreferences sharedPreferences;

  UserProfilLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<UserProfilModel> getMyUserProfil() {
    final jsonString = sharedPreferences.getString(cachedMyUserProfil);

    if (jsonString != null) {
      return Future.value(
        UserProfilModel.fromJson(json: json.decode(jsonString)),
      );
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheUserProfil({required UserProfilModel? userProfil}) async {
    if (userProfil != null) {
      sharedPreferences.setString(
        cachedMyUserProfil,
        json.encode(
          userProfil.toJson(),
        ),
      );
    } else {
      throw CacheException();
    }
  }
}
