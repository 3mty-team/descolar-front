import 'package:descolar_front/core/constants/constants.dart';
import 'package:descolar_front/core/constants/user_info.dart';
import 'package:descolar_front/features/profil/data/models/user_profil_model.dart';
import 'package:dio/dio.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/params/params.dart';
import '../models/template_model.dart';

abstract class SettingsRemoteDataSource {
  Future<List<UserProfilModel>> getBlockedUsers();
}

class SettingsRemoteDataSourceImpl implements SettingsRemoteDataSource {
  final Dio dio;

  SettingsRemoteDataSourceImpl({required this.dio});

  Options _getRequestOptions() {
    return Options(
      headers: {
        'Authorization': 'Bearer ${UserInfo.token}',
      },
      followRedirects: false,
      validateStatus: (status) => status! < 500,
    );
  }

  @override
  Future<List<UserProfilModel>> getBlockedUsers() async {
    final response = await dio.get(
      '$baseDescolarApi/user/blocks',
      options: _getRequestOptions(),
    );

    if (response.statusCode == 200) {
      List<UserProfilModel> blockedUsers = [];
      for (dynamic userJson in response.data['users']) {
        blockedUsers.add(UserProfilModel.fromJson(json: userJson));
      }
      return blockedUsers;
    } else {
      throw ServerException();
    }
  }
}
