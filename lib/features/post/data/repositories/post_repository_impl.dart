import 'package:dartz/dartz.dart';

import 'package:descolar_front/core/connection/network_info.dart';
import 'package:descolar_front/core/errors/exceptions.dart';
import 'package:descolar_front/core/errors/failure.dart';
import 'package:descolar_front/core/params/params.dart';
import 'package:descolar_front/features/post/business/entities/post_entity.dart';
import 'package:descolar_front/features/post/data/datasources/post_local_data_source.dart';
import 'package:descolar_front/features/post/data/datasources/post_remote_data_source.dart';
import 'package:descolar_front/features/post/data/models/post_model.dart';
import 'package:descolar_front/features/post/business/repositories/post_repository.dart';

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
  Future<Either<Failure, PostModel>> repostPost({required CreatePostParams params, required int postID}) async {
    if (await networkInfo.isConnected!) {
      try {
        PostModel post = await remoteDataSource.repostPost(params: params, postID: postID);
        return Right(post);
      } on ServerException {
        return Left(ServerFailure(errorMessage: 'Server exception'));
      }
    } else {
      return Left(ServerFailure(errorMessage: 'No connection'));
    }
  }

  @override
  Future<Either<Failure, bool>> deletePost({required PostEntity post}) async {
    if (await networkInfo.isConnected!) {
      try {
        return Right(await remoteDataSource.deletePost(post: post));
      } on ServerException {
        return Left(ServerFailure(errorMessage: 'Server exception'));
      }
    } else {
      return Left(ServerFailure(errorMessage: 'No connection'));
    }
  }

  @override
  Future<Either<Failure, List<PostModel>>> getAllPostInRange({
    required int range,
  }) async {
    if (await networkInfo.isConnected!) {
      try {
        List<PostModel> posts = await remoteDataSource.getAllPostInRange(range: range);
        return Right(posts);
      } on ServerException {
        return Left(ServerFailure(errorMessage: 'Server exception'));
      }
    } else {
      return Left(ServerFailure(errorMessage: 'No connection'));
    }
  }

  @override
  Future<Either<Failure, PostModel>> likePost({required PostEntity post}) async {
    if (await networkInfo.isConnected!) {
      try {
        return Right(await remoteDataSource.likePost(post: post));
      } on ServerException {
        return Left(ServerFailure(errorMessage: 'Server exception'));
      }
    } else {
      return Left(ServerFailure(errorMessage: 'No connection'));
    }
  }

  @override
  Future<Either<Failure, PostModel>> unlikePost({required PostEntity post}) async {
    if (await networkInfo.isConnected!) {
      try {
        return Right(await remoteDataSource.unlikePost(post: post));
      } on ServerException {
        return Left(ServerFailure(errorMessage: 'Server exception'));
      }
    } else {
      return Left(ServerFailure(errorMessage: 'No connection'));
    }
  }

  @override
  Future<Either<Failure, List<PostEntity>>> getLikedPost({required String userUUID}) async {
    if (await networkInfo.isConnected!) {
      try {
        List<PostEntity> posts = await remoteDataSource.getLikedPost(userUUID: userUUID);
        return Right(posts);
      } on ServerException {
        return Left(ServerFailure(errorMessage: 'Server exception'));
      }
    } else {
      return Left(ServerFailure(errorMessage: 'No connection'));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getAllReportCategories() async {
    if (await networkInfo.isConnected!) {
      try {
        List<String> categories = await remoteDataSource.getAllReportCategories();
        return Right(categories);
      } on ServerException {
        return Left(ServerFailure(errorMessage: 'Server exception'));
      }
    } else {
      return Left(ServerFailure(errorMessage: 'No connection'));
    }
  }

  @override
  Future<Either<Failure, bool>> reportPost({required ReportPostParams params}) async {
    if (await networkInfo.isConnected!) {
      try {
        return Right(await remoteDataSource.reportPost(params: params));
      } on ServerException {
        return Left(ServerFailure(errorMessage: 'Server exception'));
      }
    } else {
      return Left(ServerFailure(errorMessage: 'No connection'));
    }
  }

  @override
  Future<Either<Failure, List<PostEntity>>> getAllPostInRangeWithUserUUID({required int range, required String userUuid}) async {
    if (await networkInfo.isConnected!) {
      try {
        List<PostModel> posts = await remoteDataSource.getAllPostInRangeWithUserUUID(range: range, userUUID: userUuid);
        return Right(posts);
      } on ServerException {
        return Left(ServerFailure(errorMessage: 'Server exception'));
      }
    } else {
      return Left(ServerFailure(errorMessage: 'No connection'));
    }
  }
}
