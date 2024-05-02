import 'package:dartz/dartz.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:descolar_front/core/connection/network_info.dart';
import 'package:descolar_front/core/errors/failure.dart';
import 'package:descolar_front/features/profil/business/entities/user_profil_entity.dart';
import 'package:descolar_front/features/profil/data/datasources/user_profil_local_data_source.dart';
import 'package:descolar_front/features/profil/data/datasources/user_profil_remote_data_source.dart';
import 'package:descolar_front/features/profil/data/repositories/user_profil_repository_impl.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserProfilRepository {
  static Future<UserProfilRepository> getUserProfilRepository() async {
    return UserProfilRepositoryImpl(
      remoteDataSource: UserProfilRemoteDataSourceImpl(dio: Dio()),
      localDataSource: UserProfilLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
    );
  }

  Future<Either<Failure, UserProfilEntity>> getUserProfil({
    required String uuid,
  });

  Future<Either<Failure, UserProfilEntity>> follow({
    required String uuid,
  });

  Future<Either<Failure, UserProfilEntity>> unfollow({
    required String uuid,
  });
}
