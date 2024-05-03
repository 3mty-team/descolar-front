import 'dart:io';

import 'package:descolar_front/core/constants/constants.dart';
import 'package:descolar_front/core/constants/user_info.dart';
import 'package:dio/dio.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/user_profil_model.dart';
import 'package:path/path.dart';

abstract class UserProfilRemoteDataSource {
  Future<UserProfilModel> getUserProfil({required String uuid});
  Future<UserProfilModel> follow({required String uuid});
  Future<UserProfilModel> unfollow({required String uuid});
  Future<UserProfilModel> changeProfilPicture({required String uuid, required File image});
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
  Future<UserProfilModel> getUserProfil({required String uuid}) async {
    final responseUser = await dio.get(
      '$baseDescolarApi/user/$uuid',
      options: _getRequestOptions(),
    );

    final responseFollowers = await dio.get(
      '$baseDescolarApi/user/$uuid/followers',
      options: _getRequestOptions(),
    );

    final responseFollowing = await dio.get(
      '$baseDescolarApi/user/$uuid/following',
      options: _getRequestOptions(),
    );

    Map<String, dynamic> json = responseUser.data;
    json['followers'] = responseFollowers.data['users'];
    json['following'] = responseFollowing.data['users'];

    if (responseUser.statusCode == 200) {
      return UserProfilModel.fromJson(json: json);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UserProfilModel> follow({required String uuid}) async {
    final response = await dio.post(
      '$baseDescolarApi/user/$uuid/follow',
      options: _getRequestOptions(),
    );

    if (response.statusCode == 200) {
      return UserProfilModel.fromJson(json: response.data);
    }
    else if (response.statusCode == 403) {
      throw AlreadyExistsException();
    }
    else {
      throw ServerException();
    }
  }

  @override
  Future<UserProfilModel> unfollow({required String uuid}) async {
    final response = await dio.delete(
      '$baseDescolarApi/user/$uuid/follow',
      options: _getRequestOptions(),
    );

    if (response.statusCode == 200) {
      return UserProfilModel.fromJson(json: response.data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UserProfilModel> changeProfilPicture({required String uuid, required File image}) async {
    final responseMedia = await dio.post(
      '$baseDescolarApi/media',
      options: _getRequestOptions(),
      data: FormData.fromMap({
        'image[]': await MultipartFile.fromFile(image.path, filename: basename(image.path)),
      }),
    );

    print('RESPONSE MEDIA : ${responseMedia.statusCode}');

    if (responseMedia.statusCode == 200) {
      print(responseMedia.data);

      final responseEditProfil = await dio.put(
        '$baseDescolarApi/media',
        options: _getRequestOptions(),
        data: FormData.fromMap({
          'profile_path': responseMedia.data['path'],
        }),
      );

      print('RESPONSE EDIT PROFIL : ${responseEditProfil.statusCode}');

      if (responseEditProfil.statusCode == 200) {
        print(responseEditProfil.data);
        return UserProfilModel.fromJson(json: responseEditProfil.data);
      } else {
        throw ServerException();
      }
    } else {
      throw ServerException();
    }
  }

}
