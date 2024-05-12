import 'dart:io';

import 'package:dartz/dartz.dart';

import 'package:descolar_front/core/connection/network_info.dart';
import 'package:descolar_front/core/constants/user_info.dart';
import 'package:descolar_front/core/errors/exceptions.dart';
import 'package:descolar_front/core/errors/failure.dart';
import 'package:descolar_front/core/params/params.dart';
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
        UserProfilModel userProfil =
            await remoteDataSource.getUserProfil(uuid: uuid);
        return Right(userProfil);
      } on NotExistsException {
        return Left(NotExistsFailure(errorMessage: 'Utilisateur indisponible'));
      } on BlockedException {
        return Left(BlockedFailure(errorMessage: 'Utilisateur bloqué'));
      } on ServerException {
        return Left(ServerFailure(errorMessage: 'Erreur serveur'));
      }
    } else {
      return Left(ServerFailure(errorMessage: 'Pas de connexion'));
    }
  }

  @override
  Future<Either<Failure, bool>> follow({required String uuid}) async {
    if (await networkInfo.isConnected!) {
      try {
        await remoteDataSource.follow(uuid: uuid);
        return const Right(true);
      } on AlreadyExistsException {
        return Left(AlreadyExistsFailure(errorMessage: 'Already follow'));
      } on ServerException {
        return Left(ServerFailure(errorMessage: 'This is a server exception'));
      }
    } else {
      return Left(ServerFailure(errorMessage: 'No connection'));
    }
  }

  @override
  Future<Either<Failure, bool>> unfollow({required String uuid}) async {
    if (await networkInfo.isConnected!) {
      try {
        await remoteDataSource.unfollow(uuid: uuid);
        return const Right(true);
      } on ServerException {
        return Left(ServerFailure(errorMessage: 'This is a server exception'));
      }
    } else {
      return Left(ServerFailure(errorMessage: 'No connection'));
    }
  }

  @override
  Future<Either<Failure, bool>> changeProfilPicture(
      {required String uuid, required File image,}) async {
    if (await networkInfo.isConnected!) {
      try {
        await remoteDataSource.changeProfilPicture(uuid: uuid, image: image);
        UserProfilModel userProfil = await remoteDataSource.getUserProfil(uuid: uuid);
        await localDataSource.cacheUserProfil(userProfil: userProfil);
        UserInfo.setUserInfo();
        return const Right(true);
      } on ServerException {
        return Left(ServerFailure(errorMessage: 'This is a server exception'));
      }
    } else {
      return Left(ServerFailure(errorMessage: 'No connection'));
    }
  }

  @override
  Future<Either<Failure, bool>> block({required String uuid}) async {
    if (await networkInfo.isConnected!) {
      try {
        await remoteDataSource.block(uuid: uuid);
        return const Right(true);
      } on ServerException {
        return Left(ServerFailure(errorMessage: 'This is a server exception'));
      }
    } else {
      return Left(ServerFailure(errorMessage: 'No connection'));
    }
  }

  @override
  Future<Either<Failure, bool>> unblock({required String uuid}) async {
    if (await networkInfo.isConnected!) {
      try {
        await remoteDataSource.unblock(uuid: uuid);
        return const Right(true);
      } on NotExistsException {
        return Left(NotExistsFailure(errorMessage: 'L\'utilisateur n\'est pas bloqué'));
      }
      on ServerException {
        return Left(ServerFailure(errorMessage: 'This is a server exception'));
      }
    } else {
      return Left(ServerFailure(errorMessage: 'No connection'));
    }
  }

  @override
  Future<Either<Failure, bool>> report({required ReportUserParams params}) async {
    if (await networkInfo.isConnected!) {
      try {
        await remoteDataSource.report(params: params);
        return const Right(true);
      } on ServerException {
        return Left(ServerFailure(errorMessage: 'This is a server exception'));
      }
    } else {
      return Left(ServerFailure(errorMessage: 'No connection'));
    }
  }
}
