import 'package:dartz/dartz.dart';

import 'package:descolar_front/core/connection/network_info.dart';
import 'package:descolar_front/core/errors/exceptions.dart';
import 'package:descolar_front/core/errors/failure.dart';
import 'package:descolar_front/core/params/params.dart';
import 'package:descolar_front/features/auth/business/repositories/user_repository.dart';
import 'package:descolar_front/features/auth/data/datasources/user_local_data_source.dart';
import 'package:descolar_front/features/auth/data/datasources/user_remote_data_source.dart';
import 'package:descolar_front/features/auth/data/models/user_model.dart';

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
  Future<Either<Failure, UserModel>> getUser({required UserLoginParams params}) async {
    if (await networkInfo.isConnected!) {
      try {
        UserModel userModel = await remoteDataSource.getUser(params: params);
        return Right(userModel);
      }
      on NotExistsException {
        return Left(NotExistsFailure(errorMessage: 'Account does not exists'));
      }
      on ServerException {
        return Left(ServerFailure(errorMessage: 'Server exception'));
      }
    } else {
      return Left(ServerFailure(errorMessage: 'No connection'));
    }
  }

  @override
  Future<Either<Failure, UserModel>> createUser({required UserParams params}) async {
    if (await networkInfo.isConnected!) {
      try {
        UserModel userModel = await remoteDataSource.createUser(params: params);
        return Right(userModel);
      }
      on AlreadyExistsException {
        return Left(AlreadyExistsFailure(errorMessage: 'User already exists'));
      }
      on ServerException {
        return Left(ServerFailure(errorMessage: 'Server exception'));
      }
    } else {
      return Left(ServerFailure(errorMessage: 'No connection'));
    }
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
