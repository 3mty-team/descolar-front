import 'package:dio/dio.dart';

import 'package:descolar_front/features/search/data/models/user_result_model.dart';
import 'package:descolar_front/core/constants/constants.dart';
import 'package:descolar_front/core/constants/user_info.dart';
import 'package:descolar_front/core/errors/exceptions.dart';
import 'package:descolar_front/features/post/data/models/post_model.dart';

abstract class SearchRemoteDataSource {
  Future<List<PostModel>> getPostsByContent({required String content});

  Future<List<UserResultModel>> getUsersByUsername({required String username});
}

class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {
  final Dio dio;

  SearchRemoteDataSourceImpl({required this.dio});

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
  Future<List<PostModel>> getPostsByContent({required String content}) async {
    final response = await dio.get(
      '$baseDescolarApi/search/post',
      data: FormData.fromMap({
        'content': content,
      }),
      options: _getRequestOptions(),
    );
    if (response.statusCode == 200) {
      List<PostModel> searchResults = [];
      for (var post in response.data['posts']) {
        List<String> mediasPath = [];
        if (post['medias'] != []) {
          for (var media in post['medias']) {
            final mediaReponse = await dio.get(
              '$baseDescolarApi/media/$media',
              options: _getRequestOptions(),
            );
            mediasPath.add(mediaReponse.data['path']);
          }
        }
        PostModel? repostedPost = post['repostedPost'] == null ? null : PostModel.fromJson(json: post['repostedPost']);
        searchResults.add(PostModel.fromJson(json: post, repostedPost: repostedPost, mediasPath: mediasPath));
      }
      return searchResults;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<UserResultModel>> getUsersByUsername({required String username}) async {
    final response = await dio.get(
      '$baseDescolarApi/search/user/$username',
      options: _getRequestOptions(),
    );
    List<UserResultModel> searchResults = [];
    if (response.data['users'] != null) {
      response.data['users'].forEach((user) async {
        searchResults.add(UserResultModel.fromJson(json: user));
      });
    }
    if (response.statusCode == 200) {
      return searchResults;
    } else {
      throw ServerException();
    }
  }
}
