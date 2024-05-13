import 'package:descolar_front/core/constants/constants.dart';
import 'package:descolar_front/core/utils/date_converter.dart';
import 'package:descolar_front/features/auth/data/datasources/user_local_data_source.dart';
import 'package:dio/dio.dart';
import 'package:descolar_front/core/errors/exceptions.dart';
import 'package:descolar_front/core/params/params.dart';
import 'package:descolar_front/features/auth/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserRemoteDataSource {
  Future<String> getToken({required String uuid});

  Future<UserModel> getUser({required UserLoginParams params});

  Future<UserModel> createUser({required UserParams params});
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final Dio dio;

  UserRemoteDataSourceImpl({required this.dio});

  @override
  Future<String> getToken({
    required String uuid,
  }) async {
    final response = await dio.get('$baseDescolarApi/authentication/$uuid');
    if (response.statusCode == 200) {
      return response.data['token'];
    }
    if (response.statusCode == 404) {
      throw NotExistsException();
    } else {
      throw ServerException();
    }
  }

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
        'dateofbirth': datetimeToFormattedString(
          'MM/dd/yyyy',
          frenchFormatToDatetime(params.dateOfBirth),
        ),
        'username': params.username,
        'password': params.password,
        'formation_id': '1',
      }),
      options: Options(
        followRedirects: false,
        validateStatus: (status) => status! < 500,
      ),
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(json: response.data['user']);
    }
    if (response.statusCode == 403) {
      throw AlreadyExistsException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> getUser({required UserLoginParams params}) async {
    try {
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
        UserModel user = UserModel.fromJson(json: response.data);
        final UserLocalDataSourceImpl local = UserLocalDataSourceImpl(
          sharedPreferences: await SharedPreferences.getInstance(),
        );
        // User cache
        local.cacheUser(user: user, pfpPath: response.data['pfpPath']);
        // Remember me
        if (params.remember! == true) {
          local.cacheRememberUser(user: user);
        }
        return user;
      } else {
        throw NotValidException.fromName(response.data['message']);
      }
    } on DioException catch (e) {
      throw NotValidException.fromName(e.response?.data['message']);
    }

  }
}
