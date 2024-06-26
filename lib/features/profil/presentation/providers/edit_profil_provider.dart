import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:descolar_front/core/constants/cached_posts.dart';
import 'package:descolar_front/features/profil/business/usecases/edit_profil.dart';
import 'package:descolar_front/features/profil/data/datasources/user_profil_local_data_source.dart';
import 'package:descolar_front/features/profil/data/datasources/user_profil_remote_data_source.dart';
import 'package:descolar_front/features/profil/data/repositories/user_profil_repository_impl.dart';
import 'package:descolar_front/features/profil/presentation/providers/profil_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/components/snack_bars.dart';
import '../../../../core/connection/network_info.dart';
import '../../../../core/errors/failure.dart';
import '../../business/repositories/user_profil_repository.dart';
import '../../business/usecases/get_all_diplomas.dart';
import '../../business/usecases/get_formations_by_diploma.dart';

enum EditProfilInputName { diploma, formation, biography }

class EditProfilProvider extends ChangeNotifier {
  List<String>? diplomasList;
  List<String>? formationList;

  Map<EditProfilInputName, TextEditingController> controllers = {
    EditProfilInputName.diploma: TextEditingController(),
    EditProfilInputName.formation: TextEditingController(),
    EditProfilInputName.biography: TextEditingController(),
  };
  Map<EditProfilInputName, String?> errors = {
    EditProfilInputName.diploma: null,
    EditProfilInputName.formation: null,
    EditProfilInputName.biography: null,
  };

  void reset() {
    controllers = {
      EditProfilInputName.diploma: TextEditingController(),
      EditProfilInputName.formation: TextEditingController(),
      EditProfilInputName.biography: TextEditingController(),
    };
    errors = {
      EditProfilInputName.diploma: null,
      EditProfilInputName.formation: null,
      EditProfilInputName.biography: null,
    };
    notifyListeners();
  }

  void changeError(EditProfilInputName name, String? message) {
    this.errors[name] = message;
    notifyListeners();
  }

  void removeError(EditProfilInputName name) {
    changeError(name, null);
  }

  bool validateForm() {
    bool isValid = true;
    isValid = _validateDiploma() & isValid;
    isValid = _validateFormation() & isValid;
    return isValid;
  }

  bool _validateDiploma() {
    String value = controllers[EditProfilInputName.diploma]!.text;
    if (value.isEmpty) {
      changeError(
        EditProfilInputName.diploma,
        'Veuillez renseigner le diplôme préparé',
      );
      return false;
    }
    removeError(EditProfilInputName.diploma);
    return true;
  }

  bool _validateFormation() {
    String value = controllers[EditProfilInputName.formation]!.text;
    if (value.isEmpty) {
      changeError(
        EditProfilInputName.formation,
        'Veuillez renseigner la formation préparée',
      );
      return false;
    }
    removeError(EditProfilInputName.formation);
    return true;
  }

  Future<void> getAllDiplomas(BuildContext context) async {
    UserProfilRepository repository = await UserProfilRepository.getUserProfilRepository();
    final failureOrPost = await GetAllDiplomas(userProfilRepository: repository).call();
    failureOrPost.fold(
      (Failure failure) {
        SnackBars.failureSnackBar(context: context, title: 'Une erreur est survenue.');
        notifyListeners();
      },
      (List<String> diplomas) {
        diplomasList = diplomas;
        notifyListeners();
      },
    );
  }

  Future<void> getFormationsByDiploma(BuildContext context, int diplomaId) async {
    UserProfilRepository repository = await UserProfilRepository.getUserProfilRepository();
    final failureOrPost = await GetFormationsByDiploma(userProfilRepository: repository).call(diplomaId: diplomaId);
    failureOrPost.fold(
      (Failure failure) {
        SnackBars.failureSnackBar(context: context, title: 'Une erreur est survenue.');
        notifyListeners();
      },
      (List<String> formations) {
        formationList = formations;
        notifyListeners();
      },
    );
  }

  void updateProfil(BuildContext context, String uuid) async {
    UserProfilRepositoryImpl repository = UserProfilRepositoryImpl(
      remoteDataSource: UserProfilRemoteDataSourceImpl(dio: Dio()),
      localDataSource: UserProfilLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
    );

    final failureOrUser = await EditProfil(userProfilRepository: repository).call(
      formationId: int.parse(controllers[EditProfilInputName.formation]!.text.substring(0, 2)),
      biography: controllers[EditProfilInputName.biography]!.text,
    );

    failureOrUser.fold(
      (Failure failure) {
        SnackBars.failureSnackBar(context: context, title: 'Une erreur est survenue lors de la mise à jour de votre profil.');
        notifyListeners();
      },
      (bool response) {
        Provider.of<ProfilProvider>(context, listen: false).getUserProfil(uuid);
        CachedPost.formations.clear();
        Navigator.pop(context);
        SnackBars.successSnackBar(context: context, title: 'Votre profil a bien été mis à jour !');
        this.reset();
        notifyListeners();
      },
    );
  }
}
