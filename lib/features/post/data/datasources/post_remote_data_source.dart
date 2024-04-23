import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:descolar_front/core/constants/cached_posts.dart';
import 'package:descolar_front/core/constants/constants.dart';
import 'package:descolar_front/core/constants/user_info.dart';
import 'package:descolar_front/features/post/data/datasources/post_local_data_source.dart';
import 'package:descolar_front/features/post/data/models/post_model.dart';
import 'package:descolar_front/core/params/params.dart';

abstract class PostRemoteDataSource {
  Future<PostModel> createPost({required CreatePostParams params});

  Future<bool> deletePost({required PostModel post});

  Future<List<PostModel>> getAllPostInRange({required int range});

  Future<List<PostModel>> getAllPostInRangeWithUserUUID({
    required int range,
    required String userUUID,
  });
}

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final Dio dio;

  PostRemoteDataSourceImpl({required this.dio});

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
  Future<PostModel> createPost({required CreatePostParams params}) async {
    final response = await dio.post(
      '$baseDescolarApi/post',
      data: FormData.fromMap({
        'content': params.content,
        'location': params.location,
        'send_timestamp': params.postDate,
        'medias': '[]',
      }),
      options: _getRequestOptions(),
    );
    return PostModel.fromJson(json: response.data);
  }

  @override
  Future<bool> deletePost({required PostModel post}) async {
    int postID = post.postId;
    final response = await dio.delete(
      '$baseDescolarApi/post/$postID',
      data: FormData.fromMap({
        'post_id': postID,
      }),
      options: _getRequestOptions(),
    );
    final PostLocalDataSourceImpl local = PostLocalDataSourceImpl(sharedPreferences: await SharedPreferences.getInstance());
    local.removeFromFeed(post: post);
    return response.data['id'] != null;
  }

  @override
  Future<List<PostModel>> getAllPostInRange({required int range}) async {
    final response = await dio.get(
      '$baseDescolarApi/post/message/$range',
      options: _getRequestOptions(),
    );
    final PostLocalDataSourceImpl local = PostLocalDataSourceImpl(sharedPreferences: await SharedPreferences.getInstance());
    response.data.forEach((post) {
      local.addToFeed(post: PostModel.fromJson(json: post));
    });
    CachedPost.feed.sort((a, b) => a.postId.compareTo(b.postId));
    return CachedPost.feed;
  }

  @override
  Future<List<PostModel>> getAllPostInRangeWithUserUUID({
    required int range,
    required String userUUID,
  }) async {
    final response = await dio.get(
      '$baseDescolarApi/post/message/$userUUID/$range',
      options: _getRequestOptions(),
    );
    final PostLocalDataSourceImpl local = PostLocalDataSourceImpl(sharedPreferences: await SharedPreferences.getInstance());
    CachedPost.userPostList.clear();
    response.data.forEach((post) {
      local.addToUserPostList(post: PostModel.fromJson(json: post));
    });
    CachedPost.userPostList.sort((a, b) => a.postId.compareTo(b.postId));
    return CachedPost.userPostList;
  }
}
