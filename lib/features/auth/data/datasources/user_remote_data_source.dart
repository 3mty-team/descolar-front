import 'package:descolar_front/core/constants/constants.dart';
import 'package:dio/dio.dart';
import 'package:descolar_front/core/errors/exceptions.dart';
import 'package:descolar_front/core/params/params.dart';
import 'package:descolar_front/features/auth/data/models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> getUser({required UserLoginParams params});

  Future<UserModel> createUser({required UserParams params});
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final Dio dio;

  UserRemoteDataSourceImpl({required this.dio});

  @override
  Future<UserModel> createUser({
    required UserParams params,
  }) async {
    final response = await dio.post(
      '$baseDescolarApi/auth/register',
      data: FormData.fromMap({
        'mail': params.email,
        'lastname': params.lastname,
        'firstname': params.firstname,
        'dateofbirth': params.dateOfBirth,
        'username': params.username,
        'password': params.password,
        'formation_id': '1',
      }),
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(json: response.data['user']);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> getUser({required UserLoginParams params}) async {
    final response = await dio.get(
      '$baseDescolarApi/config/login',
      queryParameters: {
        'username': params.username,
        'password': params.password,
      },
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(json: response.data);
    } else {
      throw ServerException();
    }
  }
}
