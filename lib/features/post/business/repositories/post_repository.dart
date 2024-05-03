import 'package:dartz/dartz.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:descolar_front/features/post/business/entities/post_entity.dart';
import 'package:descolar_front/features/post/data/datasources/post_local_data_source.dart';
import 'package:descolar_front/features/post/data/datasources/post_remote_data_source.dart';
import 'package:descolar_front/core/errors/failure.dart';
import 'package:descolar_front/core/params/params.dart';
import 'package:descolar_front/features/post/data/repositories/post_repository_impl.dart';
import 'package:descolar_front/core/connection/network_info.dart';

abstract class PostRepository {
  static Future<PostRepository> getPostRepository() async {
    return PostRepositoryImpl(
      remoteDataSource: PostRemoteDataSourceImpl(dio: Dio()),
      localDataSource: PostLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
    );
  }

  Future<Either<Failure, PostEntity>> createPost({
    required CreatePostParams params,
  });

  Future<Either<Failure, PostEntity>> repostPost({
    required CreatePostParams params,
    required int postID,
  });

  Future<Either<Failure, bool>> deletePost({
    required PostEntity post,
  });

  Future<Either<Failure, PostEntity>> likePost({
    required PostEntity post,
  });

  Future<Either<Failure, PostEntity>> unlikePost({
    required PostEntity post,
  });

  Future<Either<Failure, bool>> reportPost({
    required ReportPostParams params,
  });

  Future<Either<Failure, List<PostEntity>>> getAllPostInRange({
    required int range,
  });

  Future<Either<Failure, List<PostEntity>>> getLikedPost({
    required String userUUID,
  });

  Future<Either<Failure, List<String>>> getAllReportCategories();
}
