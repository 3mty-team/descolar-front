import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:descolar_front/features/post/business/entities/post_entity.dart';
import 'package:descolar_front/core/errors/exceptions.dart';
import 'package:descolar_front/features/post/data/datasources/post_remote_data_source.dart';
import 'package:descolar_front/core/constants/cached_posts.dart';
import 'package:descolar_front/features/post/data/models/post_model.dart';

abstract class PostLocalDataSource {
  Future<void> addToFeed({required PostModel? post});

  Future<void> addToUserPostList({required PostModel? post});

  Future<void> removeFromFeed({required PostModel? post});

  Future<void> addToLikedPost({required PostModel? post});

  Future<void> removeFromLikedPost({required PostModel? post});

  Future<void> addToReportCategories({required String categorie});
}

class PostLocalDataSourceImpl implements PostLocalDataSource {
  final SharedPreferences sharedPreferences;
  final PostRemoteDataSourceImpl remote = PostRemoteDataSourceImpl(dio: Dio());

  PostLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> addToFeed({required PostModel? post}) async {
    if (post != null) {
      PostEntity? existingPost = CachedPost.postAlreadyInFeed(post);
      if (existingPost == null) {
        CachedPost.feed.add(post);
      } else {
        if ((existingPost.likes != post.likes) || (existingPost.comments != post.comments)) {
          CachedPost.feed.remove(existingPost);
          CachedPost.feed.add(post);
        }
      }
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> removeFromFeed({required PostEntity? post}) async {
    if (post != null) {
      if (CachedPost.postAlreadyInFeed(post) != null) {
        CachedPost.feed.remove(post);
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

  @override
  Future<void> addToLikedPost({required PostEntity? post}) async {
    if (post != null) {
      CachedPost.likedPost.add(post);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> removeFromLikedPost({required PostEntity? post}) async {
    if (post != null) {
      CachedPost.likedPost.remove(post);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> addToReportCategories({required String categorie}) async {
    if (!CachedPost.categorieAlreadyCached(categorie)) {
      CachedPost.reportCategories.add(categorie);
    }
  }
}
