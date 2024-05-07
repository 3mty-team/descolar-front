import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:descolar_front/features/profil/business/entities/user_profil_entity.dart';
import 'package:descolar_front/features/profil/business/repositories/user_profil_repository.dart';
import 'package:descolar_front/features/profil/business/usecases/unblock_user_profil.dart';
import 'package:descolar_front/features/settings/business/repositories/settings_repository.dart';

import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:descolar_front/core/connection/network_info.dart';
import 'package:descolar_front/core/errors/failure.dart';
import 'package:descolar_front/core/params/params.dart';
import 'package:descolar_front/features/settings/business/entities/template_entity.dart';
import 'package:descolar_front/features/settings/business/usecases/get_blocked_users.dart';
import 'package:descolar_front/features/settings/data/datasources/settings_local_data_source.dart';
import 'package:descolar_front/features/settings/data/datasources/settings_remote_data_source.dart';
import 'package:descolar_front/features/settings/data/repositories/settings_repository_impl.dart';

class SettingsProvider extends ChangeNotifier {
  List<UserProfilEntity>? blockedUsers;
  Failure? failure;

  SettingsProvider({
    this.failure,
  });

  void unblockUser(String uuid) async {
    UserProfilRepository repository =
    await UserProfilRepository.getUserProfilRepository();
    final failureOrBlock = await UnblockUserProfil(userProfilRepository: repository).call(uuid: uuid);
    failureOrBlock.fold(
          (Failure failure) {},
          (bool b) {
      },
    );
    // Refresh
    this.getBlockedUsers();
    notifyListeners();
  }

  void getBlockedUsers() async {
    SettingsRepository repository = await SettingsRepository.getSettingsRepository();

    final failureOrBlockedUsers =
        await GetBlockedUsers(settingsRepository: repository).call();
    failureOrBlockedUsers.fold(
      (Failure newFailure) {
        blockedUsers = null;
        failure = newFailure;
        notifyListeners();
      },
      (List<UserProfilEntity> blockedUserEntities) {
        blockedUsers = blockedUserEntities;
        failure = null;
        notifyListeners();
      },
    );
  }
}
