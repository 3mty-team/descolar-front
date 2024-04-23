import 'package:dartz/dartz.dart';
import 'package:descolar_front/core/connection/network_info.dart';
import 'package:descolar_front/core/errors/exceptions.dart';
import 'package:descolar_front/core/errors/failure.dart';
import 'package:descolar_front/core/params/params.dart';
import 'package:descolar_front/features/post/business/entities/post_entity.dart';
import 'package:descolar_front/features/post/data/datasources/post_local_data_source.dart';
import 'package:descolar_front/features/post/data/datasources/post_remote_data_source.dart';
import 'package:descolar_front/features/post/data/models/post_model.dart';

import '../../business/repositories/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource remoteDataSource;
  final PostLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PostRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, PostModel>> createPost({
    required CreatePostParams params,
  }) async {
    if (await networkInfo.isConnected!) {
      try {
        PostModel postModel = await remoteDataSource.createPost(params: params);
        return Right(postModel);
      } on ServerException {
        return Left(ServerFailure(errorMessage: 'Server exception'));
      }
    } else {
      return Left(ServerFailure(errorMessage: 'No connection'));
    }
  }

  @override
  Future<Either<Failure, PostEntity>> deletePost({required int postID}) {
    // TODO: implement deletePost
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<PostModel>>> getAllPostInRange({
    required int range,
  }) async {
    if (await networkInfo.isConnected!) {
      try {
        List<PostModel> posts =
            await remoteDataSource.getAllPostInRange(range: range);
        return Right(posts);
      } on ServerException {
        return Left(ServerFailure(errorMessage: 'Server exception'));
      }
    } else {
      return Left(ServerFailure(errorMessage: 'No connection'));
    }
  }

  @override
  Future<Either<Failure, List<PostEntity>>> getAllPostInRangeWithTimestamp({
    required int range,
    required DateTime timestamp,
  }) {
    // TODO: implement getAllPostInRangeWithTimestamp
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<PostEntity>>> getAllPostInRangeWithUserUUID({
    required int range,
    required String userUUID,
  }) async {
    if (await networkInfo.isConnected!) {
      try {
        List<PostModel> posts = await remoteDataSource
            .getAllPostInRangeWithUserUUID(range: range, userUUID: userUUID);
        return Right(posts);
      } on ServerException {
        return Left(ServerFailure(errorMessage: 'Server exception'));
      }
    } else {
      return Left(ServerFailure(errorMessage: 'No connection'));
    }
  }

  @override
  Future<Either<Failure, PostEntity>> getPostByID({required int postID}) {
    // TODO: implement getPostByID
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, PostEntity>> repostPost({required int postID}) {
    // TODO: implement repostPost
    throw UnimplementedError();
  }
}
