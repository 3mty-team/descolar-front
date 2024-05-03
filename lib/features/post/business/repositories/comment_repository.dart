import 'package:dartz/dartz.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:descolar_front/features/post/business/entities/post_entity.dart';
import 'package:descolar_front/features/post/business/entities/comment_entity.dart';
import 'package:descolar_front/core/errors/failure.dart';
import 'package:descolar_front/core/params/params.dart';
import 'package:descolar_front/features/post/data/datasources/comment_local_data_source.dart';
import 'package:descolar_front/features/post/data/datasources/comment_remote_data_source.dart';
import 'package:descolar_front/features/post/data/repositories/comment_repository_impl.dart';
import 'package:descolar_front/core/connection/network_info.dart';

abstract class CommentRepository {
  static Future<CommentRepository> getCommentRepository() async {
    return CommentRepositoryImpl(
      remoteDataSource: CommentRemoteDateSourceImpl(dio: Dio()),
      localDataSource: CommentLocalDateSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
    );
  }

  Future<Either<Failure, CommentEntity>> createComment({
    required CreateCommentParams params,
  });

  Future<Either<Failure, bool>> deleteComment({
    required CommentEntity comment,
  });

  Future<Either<Failure, List<CommentEntity>>> getAllCommentsInRange({
    required PostEntity post,
    required int range,
  });
}
