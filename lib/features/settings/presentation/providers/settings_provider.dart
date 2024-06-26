import 'package:descolar_front/core/resources/app_colors.dart';
import 'package:descolar_front/features/profil/business/entities/user_profil_entity.dart';
import 'package:descolar_front/features/profil/business/repositories/user_profil_repository.dart';
import 'package:descolar_front/features/profil/business/usecases/unblock_user_profil.dart';
import 'package:descolar_front/features/settings/business/repositories/settings_repository.dart';
import 'package:descolar_front/core/errors/failure.dart';
import 'package:descolar_front/features/settings/business/usecases/get_blocked_users.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SettingsProvider extends ChangeNotifier {
  List<UserProfilEntity>? blockedUsers;
  Failure? failure;
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  SettingsProvider({
    this.failure,
  });

  void unblockUser(String uuid) async {
    UserProfilRepository repository = await UserProfilRepository.getUserProfilRepository();
    final failureOrBlock = await UnblockUserProfil(userProfilRepository: repository).call(uuid: uuid);
    failureOrBlock.fold(
      (Failure failure) {},
      (bool b) {},
    );
    // Refresh
    this.getBlockedUsers();
    notifyListeners();
  }

  void getBlockedUsers() async {
    SettingsRepository repository = await SettingsRepository.getSettingsRepository();

    final failureOrBlockedUsers = await GetBlockedUsers(settingsRepository: repository).call();
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

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    if (_isDarkMode) {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          systemNavigationBarColor: AppColors.primaryDark,
          statusBarColor: Colors.transparent,
        ),
      );
    }
    else {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          systemNavigationBarColor: AppColors.primary,
          statusBarColor: Colors.transparent,
        ),
      );
    }
    notifyListeners();
  }
}
