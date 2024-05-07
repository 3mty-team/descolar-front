import 'package:dartz/dartz.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:descolar_front/core/connection/network_info.dart';
import 'package:descolar_front/core/errors/failure.dart';
import 'package:descolar_front/features/profil/business/entities/user_profil_entity.dart';
import 'package:descolar_front/features/settings/data/datasources/settings_local_data_source.dart';
import 'package:descolar_front/features/settings/data/datasources/settings_remote_data_source.dart';
import 'package:descolar_front/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SettingsRepository {
  static Future<SettingsRepository> getSettingsRepository() async {
    return SettingsRepositoryImpl(
      remoteDataSource: SettingsRemoteDataSourceImpl(dio: Dio()),
      localDataSource: SettingsLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
    );
  }

  Future<Either<Failure, List<UserProfilEntity>>> getBlockedUsers();
}
