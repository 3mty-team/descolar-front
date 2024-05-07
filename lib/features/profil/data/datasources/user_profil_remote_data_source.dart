import 'dart:io';

import 'package:descolar_front/core/constants/constants.dart';
import 'package:descolar_front/core/constants/user_info.dart';
import 'package:descolar_front/core/params/params.dart';
import 'package:descolar_front/core/utils/file_utils.dart';
import 'package:dio/dio.dart';
import 'package:descolar_front/core/errors/exceptions.dart';
import 'package:descolar_front/features/profil/data/models/user_profil_model.dart';

abstract class UserProfilRemoteDataSource {
  Future<UserProfilModel> getUserProfil({required String uuid});

  Future<bool> follow({required String uuid});

  Future<bool> unfollow({required String uuid});

  Future<bool> changeProfilPicture({required String uuid, required File image});

  Future<bool> block({required String uuid});

  Future<bool> unblock({required String uuid});

  Future<bool> report({required ReportUserParams params});
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

    if (responseUser.statusCode == 200) {
      // Check if user is blocked
      final responseBlocked = await dio.get(
        '$baseDescolarApi/user/$uuid/block',
        options: _getRequestOptions(),
      );

      if (responseBlocked.statusCode == 200) {
        if (responseBlocked.data['result'] == false) {
          // Get followers/following
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

          return UserProfilModel.fromJson(json: json);
        } else {
          throw BlockedException();
        }
      } else {
        throw BlockedException();
      }
    } else if (responseUser.statusCode == 400) {
      throw NotExistsException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<bool> follow({required String uuid}) async {
    final response = await dio.post(
      '$baseDescolarApi/user/$uuid/follow',
      options: _getRequestOptions(),
    );

    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 403) {
      throw AlreadyExistsException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<bool> unfollow({required String uuid}) async {
    final response = await dio.delete(
      '$baseDescolarApi/user/$uuid/follow',
      options: _getRequestOptions(),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<bool> changeProfilPicture(
      {required String uuid, required File image,}) async {
    final responseMedia = await dio.post(
      '$baseDescolarApi/media',
      options: _getRequestOptions(),
      data: FormData.fromMap({
        'image[]': await MultipartFile.fromFile(image.path,
            filename: FileUtils.getFileName(image.path),
            contentType: FileUtils.getMediaType('image', image.path),),
      }),
    );

    if (responseMedia.statusCode == 200) {
      final responseEditProfil = await dio.put(
        '$baseDescolarApi/user',
        options: _getRequestOptions(),
        data: FormData.fromMap({
          'profile_path': responseMedia.data['medias'][0]['path'],
          'send_timestamp': 20,
        }),
      );

      if (responseEditProfil.statusCode == 200) {
        return true;
      } else {
        throw ServerException();
      }
    } else {
      throw ServerException();
    }
  }

  @override
  Future<bool> block({required String uuid}) async {
    final response = await dio.post(
      '$baseDescolarApi/user/$uuid/block',
      options: _getRequestOptions(),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<bool> unblock({required String uuid}) async {
    final response = await dio.delete(
      '$baseDescolarApi/user/$uuid/block',
      options: _getRequestOptions(),
    );

    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 403) {
      throw NotExistsException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<bool> report({required ReportUserParams params}) async {
    final response = await dio.post(
      '$baseDescolarApi/report/user/create',
      options: _getRequestOptions(),
      data: FormData.fromMap({
        'reported_uuid': params.uuid,
        'report_category_id': params.category,
        'comment': params.comment,
        'date': params.date,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw ServerException();
    }
  }
}
