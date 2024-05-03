import 'package:dartz/dartz.dart';

import 'package:descolar_front/core/connection/network_info.dart';
import 'package:descolar_front/core/errors/failure.dart';
import 'package:descolar_front/core/params/params.dart';
import 'package:descolar_front/features/post/business/entities/comment_entity.dart';
import 'package:descolar_front/features/post/business/entities/post_entity.dart';
import 'package:descolar_front/features/post/business/repositories/comment_repository.dart';
import 'package:descolar_front/features/post/data/datasources/comment_local_data_source.dart';
import 'package:descolar_front/features/post/data/datasources/comment_remote_data_source.dart';
import 'package:descolar_front/features/post/data/models/comment_model.dart';
import 'package:descolar_front/core/errors/exceptions.dart';
import 'package:descolar_front/features/post/data/models/post_model.dart';

class CommentRepositoryImpl implements CommentRepository {
  final CommentRemoteDateSource remoteDataSource;
  final CommentLocalDateSource localDataSource;
  final NetworkInfo networkInfo;

  CommentRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, CommentModel>> createComment({required CreateCommentParams params}) async {
    if (await networkInfo.isConnected!) {
      try {
        CommentModel commentModel = await remoteDataSource.createComment(params: params);
        return Right(commentModel);
      } on ServerException {
        return Left(ServerFailure(errorMessage: 'Server exception'));
      }
    } else {
      return Left(ServerFailure(errorMessage: 'No connection'));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteComment({required CommentEntity comment}) async {
    if (await networkInfo.isConnected!) {
      try {
        bool response = await remoteDataSource.deleteComment(comment: comment);
        return Right(response);
      } on ServerException {
        return Left(ServerFailure(errorMessage: 'Server exception'));
      }
    } else {
      return Left(ServerFailure(errorMessage: 'No connection'));
    }
  }

  @override
  Future<Either<Failure, List<CommentModel>>> getAllCommentsInRange({required PostEntity post, required int range}) async {
    if (await networkInfo.isConnected!) {
      try {
        List<CommentModel> comments = await remoteDataSource.getAllCommentsInRange(post: post, range: range);
        return Right(comments);
      } on ServerException {
        return Left(ServerFailure(errorMessage: 'Server exception'));
      }
    } else {
      return Left(ServerFailure(errorMessage: 'No connection'));
    }
  }
}
