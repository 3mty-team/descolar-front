import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:descolar_front/core/errors/exceptions.dart';
import 'package:descolar_front/features/post/business/entities/post_entity.dart';
import 'package:descolar_front/core/constants/cached_posts.dart';
import 'package:descolar_front/core/constants/constants.dart';
import 'package:descolar_front/core/constants/user_info.dart';
import 'package:descolar_front/features/post/data/datasources/post_local_data_source.dart';
import 'package:descolar_front/features/post/data/models/post_model.dart';
import 'package:descolar_front/core/params/params.dart';

abstract class PostRemoteDataSource {
  Future<PostModel> createPost({required CreatePostParams params});

  Future<PostModel> repostPost({required CreatePostParams params, required int postID});

  Future<bool> deletePost({required PostEntity post});

  Future<PostModel> likePost({required PostEntity post});

  Future<PostModel> unlikePost({required PostEntity post});

  Future<bool> reportPost({required ReportPostParams params});

  Future<List<PostModel>> getAllPostInRange({required int range});

  Future<List<PostEntity>> getLikedPost({required String userUUID});

  Future<List<String>> getAllReportCategories();

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
    if (response.statusCode == 200) {
      return PostModel.fromJson(json: response.data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<PostModel> repostPost({required CreatePostParams params, required int postID}) async {
    final response = await dio.post(
      '$baseDescolarApi/repost',
      data: FormData.fromMap({
        'post_id': postID,
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
  Future<bool> deletePost({required PostEntity post}) async {
    int postID = post.postId;
    final response = await dio.delete(
      '$baseDescolarApi/post/$postID',
      data: FormData.fromMap({
        'post_id': postID,
      }),
      options: _getRequestOptions(),
    );
    if (response.statusCode == 200) {
      final PostLocalDataSourceImpl local = PostLocalDataSourceImpl(sharedPreferences: await SharedPreferences.getInstance());
      local.removeFromFeed(post: post);
      return response.data['id'] != null;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<PostModel> likePost({required PostEntity post}) async {
    int postID = post.postId;
    final response = await dio.post(
      '$baseDescolarApi/post/$postID/like',
      options: _getRequestOptions(),
    );
    if (response.statusCode == 200) {
      final PostLocalDataSourceImpl local = PostLocalDataSourceImpl(sharedPreferences: await SharedPreferences.getInstance());
      local.addToLikedPost(post: post);
      return PostModel.fromJson(json: response.data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<PostModel> unlikePost({required PostEntity post}) async {
    int postID = post.postId;
    final response = await dio.delete(
      '$baseDescolarApi/post/$postID/like',
      options: _getRequestOptions(),
    );
    if (response.statusCode == 200) {
      final PostLocalDataSourceImpl local = PostLocalDataSourceImpl(sharedPreferences: await SharedPreferences.getInstance());
      local.removeFromLikedPost(post: post);
      return PostModel.fromJson(json: response.data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<bool> reportPost({required ReportPostParams params}) async {
    final response = await dio.post(
      '$baseDescolarApi/report/post/create',
      data: FormData.fromMap({
        'post_id': params.post.postId,
        'report_category_id': params.reportCategoryID,
        'comment': params.comment,
        'date': params.date,
      }),
      options: _getRequestOptions(),
    );
    if (response.statusCode == 200) {
      return response.data['id'] != null;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<PostModel>> getAllPostInRange({required int range}) async {
    final response = await dio.get(
      '$baseDescolarApi/post/message/$range',
      options: _getRequestOptions(),
    );
    final PostLocalDataSourceImpl local = PostLocalDataSourceImpl(sharedPreferences: await SharedPreferences.getInstance());
    response.data.forEach((post) async {
      PostModel? repostedPost = post['repostedPost'] == null ? null : PostModel.fromJson(json: post['repostedPost']);
      local.addToFeed(post: PostModel.fromJson(json: post, repostedPost: repostedPost));
    });
    if (response.statusCode == 200) {
      CachedPost.feed.sort((a, b) => a.postId.compareTo(b.postId));
      return CachedPost.feed;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<PostEntity>> getLikedPost({required String userUUID}) async {
    final response = await dio.get(
      '$baseDescolarApi/post/$userUUID/like',
      options: _getRequestOptions(),
    );
    if (response.statusCode == 200) {
      final PostLocalDataSourceImpl local = PostLocalDataSourceImpl(sharedPreferences: await SharedPreferences.getInstance());
      CachedPost.likedPost.clear();
      response.data['posts'].forEach((post) {
        local.addToLikedPost(post: PostModel.fromJson(json: post));
      });
      return CachedPost.likedPost;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<String>> getAllReportCategories() async {
    final response = await dio.get(
      '$baseDescolarApi/report/category',
      options: _getRequestOptions(),
    );
    if (response.statusCode == 200) {
      final PostLocalDataSourceImpl local = PostLocalDataSourceImpl(sharedPreferences: await SharedPreferences.getInstance());
      response.data['report_categories'].forEach((categorie) {
        local.addToReportCategories(categorie: categorie);
      });
      return CachedPost.reportCategories;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<PostModel>> getAllPostInRangeWithUserUUID({
    required int range,
    required String userUUID,
  }) async {
    final response = await dio.get(
      '$baseDescolarApi/post/message/$userUUID/$range/20',
      options: _getRequestOptions(),
    );

    List<PostModel> posts = [];
    for (dynamic postJson in response.data) {
      PostModel? repostedPost = postJson['repostedPost'] == null ? null : PostModel.fromJson(json: postJson['repostedPost']);
      posts.add(PostModel.fromJson(json: postJson, repostedPost: repostedPost));
    }
    return posts;
  }
}
