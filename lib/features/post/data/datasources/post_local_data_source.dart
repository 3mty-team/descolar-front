import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:descolar_front/core/errors/exceptions.dart';
import 'package:descolar_front/features/post/data/datasources/post_remote_data_source.dart';
import 'package:descolar_front/core/constants/cached_posts.dart';
import 'package:descolar_front/features/post/data/models/post_model.dart';

abstract class PostLocalDataSource {
  Future<void> addToFeed({required PostModel? post});

  Future<void> addToUserPostList({required PostModel? post});
}

class PostLocalDataSourceImpl implements PostLocalDataSource {
  final SharedPreferences sharedPreferences;
  final PostRemoteDataSourceImpl remote = PostRemoteDataSourceImpl(dio: Dio());

  PostLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> addToFeed({required PostModel? post}) async {
    if (post != null) {
      if (!CachedPost.postAlreadyInFeed(post)) {
        CachedPost.feed.add(post);
      }
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> addToUserPostList({required PostModel? post}) async {
    if (post != null) {
      if (!CachedPost.postAlreadyInUserList(post)) {
        CachedPost.feed.add(post);
      }
    } else {
      throw CacheException();
    }
  }
}
