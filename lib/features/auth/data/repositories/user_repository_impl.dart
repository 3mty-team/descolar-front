import 'package:dartz/dartz.dart';
import 'package:descolar_front/features/auth/business/entities/user_entity.dart';
import 'package:dio/src/response.dart';

import '../../../../core/connection/network_info.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/params/params.dart';
import '../../business/repositories/user_repository.dart';
import '../datasources/template_local_data_source.dart';
import '../datasources/user_remote_data_source.dart';
import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, UserEntity>> getUser({required UserParams params}) {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Response>> createUser({required UserParams params}) {
    // TODO: implement createUser
    throw UnimplementedError();
  }

  // @override
  // Future<Either<Failure, UserModel>> getUser({
  //   required UserParams templateParams,
  // }) async {
  //   if (await networkInfo.isConnected!) {
  //     try {
  //       UserModel remoteUser =
  //           await remoteDataSource.getUser(templateParams: templateParams);
  //
  //       localDataSource.cacheUser(templateToCache: remoteUser);
  //
  //       return Right(remoteUser);
  //     } on ServerException {
  //       return Left(ServerFailure(errorMessage: 'This is a server exception'));
  //     }
  //   } else {
  //     try {
  //       UserModel localUser = await localDataSource.getLastUser();
  //       return Right(localUser);
  //     } on CacheException {
  //       return Left(CacheFailure(errorMessage: 'This is a cache exception'));
  //     }
  //   }
  // }
}
