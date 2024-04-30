import 'package:dartz/dartz.dart';

import 'package:descolar_front/core/connection/network_info.dart';
import 'package:descolar_front/core/constants/user_info.dart';
import 'package:descolar_front/core/errors/exceptions.dart';
import 'package:descolar_front/core/errors/failure.dart';
import 'package:descolar_front/core/params/params.dart';
import 'package:descolar_front/features/profil/business/entities/user_profil_entity.dart';
import 'package:descolar_front/features/profil/business/repositories/user_profil_repository.dart';
import 'package:descolar_front/features/profil/data/datasources/user_profil_local_data_source.dart';
import 'package:descolar_front/features/profil/data/datasources/user_profil_remote_data_source.dart';
import 'package:descolar_front/features/profil/data/models/user_profil_model.dart';

class UserProfilRepositoryImpl implements UserProfilRepository {
  final UserProfilRemoteDataSource remoteDataSource;
  final UserProfilLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  UserProfilRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, UserProfilModel>> getUserProfil({
    required String uuid,
  }) async {
    if (await networkInfo.isConnected!) {
      try {
        // If my user profil
        // if (uuid == UserInfo.user.uuid) {
        //   UserProfilModel localTemplate = await localDataSource.getMyUserProfil();
        //   return Right(localTemplate);
        // }
        UserProfilModel remoteTemplate = await remoteDataSource.getUserProfil(uuid: uuid);
        return Right(remoteTemplate);
      } on ServerException {
        return Left(ServerFailure(errorMessage: 'This is a server exception'));
      }
    } else {
      return Left(ServerFailure(errorMessage: 'No connection'));
    }
  }

  @override
  Future<Either<Failure, UserProfilEntity>> getMyUserProfil({required String uuid}) {
    // TODO: implement getMyUserProfil
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserProfilEntity>> getUserFollowing({required String uuid}) {
    // TODO: implement getUserFollowing
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserProfilEntity>> getUserFollowers({required String uuid}) {
    // TODO: implement getUserFollowers
    throw UnimplementedError();
  }
}
