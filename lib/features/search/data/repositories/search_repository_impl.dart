import 'package:dartz/dartz.dart';
import 'package:descolar_front/core/connection/network_info.dart';
import 'package:descolar_front/core/errors/failure.dart';
import 'package:descolar_front/features/post/business/entities/post_entity.dart';
import 'package:descolar_front/features/search/business/entities/user_result_entity.dart';
import 'package:descolar_front/features/search/business/repositories/search_repository.dart';
import 'package:descolar_front/features/search/data/datasources/search_local_data_source.dart';
import 'package:descolar_front/features/search/data/datasources/search_remote_data_source.dart';
import 'package:descolar_front/features/search/data/models/user_result_model.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../post/data/models/post_model.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchRemoteDataSource remoteDataSource;
  final SearchLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  SearchRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<PostEntity>>> getPostsByContent({required String content}) async {
    if (await networkInfo.isConnected!) {
      try {
        List<PostModel> posts = await remoteDataSource.getPostsByContent(content: content);
        return Right(posts);
      } on ServerException {
        return Left(ServerFailure(errorMessage: 'Server exception'));
      }
    } else {
      return Left(ServerFailure(errorMessage: 'No connection'));
    }
  }

  @override
  Future<Either<Failure, List<UserResultEntity>>> getUsersByUsername({required String username}) async {
    if (await networkInfo.isConnected!) {
      try {
        List<UserResultModel> users = await remoteDataSource.getUsersByUsername(username: username);
        return Right(users);
      } on ServerException {
        return Left(ServerFailure(errorMessage: 'Server exception'));
      }
    } else {
      return Left(ServerFailure(errorMessage: 'No connection'));
    }
  }
}
