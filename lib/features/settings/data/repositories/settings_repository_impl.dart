import 'package:dartz/dartz.dart';
import 'package:descolar_front/features/profil/data/models/user_profil_model.dart';

import '../../../../core/connection/network_info.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../business/repositories/settings_repository.dart';
import '../datasources/settings_local_data_source.dart';
import '../datasources/settings_remote_data_source.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsRemoteDataSource remoteDataSource;
  final SettingsLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  SettingsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<UserProfilModel>>> getBlockedUsers() async {
    if (await networkInfo.isConnected!) {
      try {
        List<UserProfilModel> blockedUsers =
            await remoteDataSource.getBlockedUsers();
        return Right(blockedUsers);
      } on ServerException {
        return Left(ServerFailure(errorMessage: 'Erreur serveur'));
      }
    } else {
      return Left(ServerFailure(errorMessage: 'Pas de connexion'));
    }
  }
}
