import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:descolar_front/features/auth/business/entities/user_entity.dart';

import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:descolar_front/core/connection/network_info.dart';
import 'package:descolar_front/core/errors/failure.dart';
import 'package:descolar_front/core/params/params.dart';
import 'package:descolar_front/features/profil/business/entities/user_profil_entity.dart';
import 'package:descolar_front/features/profil/business/usecases/get_user_profil.dart';
import 'package:descolar_front/features/profil/data/datasources/user_profil_local_data_source.dart';
import 'package:descolar_front/features/profil/data/datasources/user_profil_remote_data_source.dart';
import 'package:descolar_front/features/profil/data/repositories/user_profil_repository_impl.dart';


class ProfilProvider extends ChangeNotifier {
  UserProfilEntity userProfil = const UserProfilEntity(uuid: '', lastname: '-', firstname: '-', username: '-', followers: [], following: [],);
  Failure? failure;

  ProfilProvider({
    //this.userProfil,
    this.failure,
  });

  void getUserProfil(String uuid) async {
    userProfil = const UserProfilEntity(uuid: '', lastname: '-', firstname: '-', username: '-', followers: [], following: [],);
    notifyListeners();

    UserProfilRepositoryImpl repository = UserProfilRepositoryImpl(
      remoteDataSource: UserProfilRemoteDataSourceImpl(
        dio: Dio(),
      ),
      localDataSource: UserProfilLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    // Get User infos
    final failureOrUserProfil = await GetUserProfil(userProfilRepository: repository).call(uuid: uuid);
    failureOrUserProfil.fold(
      (Failure newFailure) {
        userProfil = const UserProfilEntity(uuid: '', lastname: '-', firstname: '-', username: '-', followers: [], following: [],);
        failure = newFailure;
        notifyListeners();
      },
      (UserProfilEntity newTemplate) {
        userProfil = newTemplate;
        failure = null;

        notifyListeners();
      },
    );


  }
}
