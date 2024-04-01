import 'package:descolar_front/core/constants/constants.dart';
import 'package:descolar_front/core/utils/date_converter.dart';
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
    final response = await dio.post('$baseDescolarApi/auth/register',
        data: FormData.fromMap({
          'mail': params.email,
          'lastname': params.lastname,
          'firstname': params.firstname,
          'dateofbirth': datetimeToFormattedString('MM/dd/yyyy', frenchFormatToDatetime(params.dateOfBirth)),
          'username': params.username,
          'password': params.password,
          'formation_id': '1',
        }),
        options: Options(
          followRedirects: false,
          validateStatus: (status) => status! < 500,
        ));

    if (response.statusCode == 200) {
      return UserModel.fromJson(json: response.data['user']);
    } else if (response.statusCode == 400) {
      print(response);
      print(response.data['message']);
      throw AlreadyExistsException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> getUser({required UserLoginParams params}) async {
    final response = await dio.post(
      '$baseDescolarApi/config/login',
      data: FormData.fromMap(
        {
          'username': params.username,
          'password': params.password,
        },
      ),
    );

    if (response.statusCode == 200) {
      if (response.data['error'] != null) {
        throw NotExistsException();
      }
      return UserModel.fromJson(json: response.data['user']);
    } else {
      throw ServerException();
    }
  }
}
