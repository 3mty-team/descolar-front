import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:descolar_front/core/constants/user_info.dart';
import 'package:descolar_front/features/auth/business/entities/user_entity.dart';
import 'package:descolar_front/features/profil/business/usecases/follow_user_profil.dart';
import 'package:descolar_front/features/profil/business/usecases/unfollow_user_profil.dart';

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
  UserProfilEntity? userProfil;
  Failure? failure;
  bool isMyUserProfil = false;
  bool isFollower = false;

  ProfilProvider({
    //this.userProfil,
    this.failure,
  });

  // Check if a current user is a follower of this.userProfil
  bool checkIsFollower() {
    for (UserProfilEntity follower in userProfil!.followers) {
      if (follower.uuid == UserInfo.user.uuid) {
        return true;
      }
    }
    return false;
  }

  void follow(String uuid) async {
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

    final failureOrUserProfil = await FollowUserProfil(userProfilRepository: repository).call(uuid: uuid);
    failureOrUserProfil.fold(
      (Failure failure) {
        if (failure is AlreadyExistsFailure) {
          print('already exists');
        } else if (failure is ServerFailure) {
          print('server failed');
        }
      },
      (UserProfilEntity userProfilEntity) {
        print('user follow');
        getUserProfil(uuid);
      },
    );

    notifyListeners();
  }

  void unfollow(String uuid) async {
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

    final failureOrUserProfil = await UnfollowUserProfil(userProfilRepository: repository).call(uuid: uuid);
    failureOrUserProfil.fold(
      (Failure failure) {
        if (failure is AlreadyExistsFailure) {
          print('already exists');
        } else if (failure is ServerFailure) {
          print('server failed');
        }
      },
      (UserProfilEntity userProfilEntity) {
        print('user unfollow');
        getUserProfil(uuid);
      },
    );

    notifyListeners();
  }

  void getUserProfil(String uuid) async {
    userProfil = null;
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
    if (uuid == UserInfo.user.uuid) {
      this.isMyUserProfil = true;
    } else {
      this.isMyUserProfil = false;
    }
    final failureOrUserProfil = await GetUserProfil(userProfilRepository: repository).call(uuid: uuid);
    failureOrUserProfil.fold(
      (Failure failure) {
        userProfil = null;
        failure = failure;
        notifyListeners();
      },
      (UserProfilEntity userProfilEntity) {
        userProfil = userProfilEntity;
        failure = null;

        if (!this.isMyUserProfil) {
          this.isFollower = checkIsFollower();
        }

        notifyListeners();
      },
    );
  }
}
