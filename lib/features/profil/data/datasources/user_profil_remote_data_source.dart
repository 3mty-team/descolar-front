import 'package:descolar_front/core/constants/constants.dart';
import 'package:descolar_front/core/constants/user_info.dart';
import 'package:dio/dio.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/params/params.dart';
import '../models/user_profil_model.dart';

abstract class UserProfilRemoteDataSource {
  Future<UserProfilModel> getUserProfil({required String uuid});
}

class UserProfilRemoteDataSourceImpl implements UserProfilRemoteDataSource {
  final Dio dio;

  UserProfilRemoteDataSourceImpl({required this.dio});

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
  Future<UserProfilModel> getUserProfil(
      {required String uuid,}) async {
    final response = await dio.get(
      '$baseDescolarApi/user/$uuid',
      options: _getRequestOptions(),
    );

    if (response.statusCode == 200) {
      return UserProfilModel.fromJson(json: response.data);
    } else {
      throw ServerException();
    }
  }
}
