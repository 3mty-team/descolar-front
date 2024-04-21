import 'package:dartz/dartz.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:descolar_front/core/connection/network_info.dart';

import 'package:descolar_front/features/auth/business/entities/user_entity.dart';
import 'package:descolar_front/core/errors/failure.dart';
import 'package:descolar_front/core/params/params.dart';
import 'package:descolar_front/features/auth/data/datasources/user_local_data_source.dart';
import 'package:descolar_front/features/auth/data/datasources/user_remote_data_source.dart';
import 'package:descolar_front/features/auth/data/repositories/user_repository_impl.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserRepository {

  static Future<UserRepository> getUserRepository() async {
    return UserRepositoryImpl(
      remoteDataSource: UserRemoteDataSourceImpl(dio: Dio()),
      localDataSource: UserLocalDataSourceImpl(
          sharedPreferences: await SharedPreferences.getInstance(),
    ),
    networkInfo: NetworkInfoImpl(DataConnectionChecker()),
    );
  }

  Future<Either<Failure, UserEntity>> getUser({
    required UserLoginParams params,
  });

  Future<Either<Failure, UserEntity?>> getRememberUser();

  Future<Either<Failure, UserEntity>> createUser({
    required UserParams params,
  });


}
