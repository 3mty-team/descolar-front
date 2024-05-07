import 'package:dartz/dartz.dart';

import 'package:descolar_front/core/errors/failure.dart';
import 'package:descolar_front/features/profil/business/entities/user_profil_entity.dart';
import 'package:descolar_front/features/settings/business/repositories/settings_repository.dart';

class GetBlockedUsers {
  final SettingsRepository settingsRepository;

  GetBlockedUsers({required this.settingsRepository});

  Future<Either<Failure, List<UserProfilEntity>>> call() async {
    return await settingsRepository.getBlockedUsers();
  }
}
