import 'dart:io';

import 'package:descolar_front/core/constants/user_info.dart';
import 'package:descolar_front/features/post/business/entities/post_entity.dart';
import 'package:descolar_front/features/post/business/repositories/post_repository.dart';
import 'package:descolar_front/features/post/business/usecases/get_all_post_in_range_with_user_uuid.dart';
import 'package:descolar_front/features/profil/business/repositories/user_profil_repository.dart';
import 'package:descolar_front/features/profil/business/usecases/block_user_profil.dart';
import 'package:descolar_front/features/profil/business/usecases/change_profil_picture.dart';
import 'package:descolar_front/features/profil/business/usecases/follow_user_profil.dart';
import 'package:descolar_front/features/profil/business/usecases/unfollow_user_profil.dart';

import 'package:flutter/material.dart';

import 'package:descolar_front/core/errors/failure.dart';
import 'package:descolar_front/features/profil/business/entities/user_profil_entity.dart';
import 'package:descolar_front/features/profil/business/usecases/get_user_profil.dart';
import 'package:image_picker/image_picker.dart';

class ProfilProvider extends ChangeNotifier {
  UserProfilEntity? userProfil;
  Failure? failure;
  bool isMyUserProfil = false;
  bool isFollower = false;
  List<PostEntity> posts = [];

  ProfilProvider({
    this.userProfil,
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

  void follow() async {
    if (!isMyUserProfil) {
      UserProfilRepository repository =
      await UserProfilRepository.getUserProfilRepository();

      final failureOrFollow =
      await FollowUserProfil(userProfilRepository: repository)
          .call(uuid: userProfil!.uuid);
      failureOrFollow.fold(
            (Failure failure) {
          if (failure is AlreadyExistsFailure) {
          } else if (failure is ServerFailure) {}
        },
            (bool b) {},
      );

      // Refresh
      this.getUserProfil(userProfil!.uuid);
      notifyListeners();
    }

  }

  void unfollow() async {
    if (!isMyUserProfil) {
      UserProfilRepository repository =
      await UserProfilRepository.getUserProfilRepository();

      final failureOrUnfollow =
      await UnfollowUserProfil(userProfilRepository: repository)
          .call(uuid: userProfil!.uuid);
      failureOrUnfollow.fold(
            (Failure failure) {
          if (failure is AlreadyExistsFailure) {
          } else if (failure is ServerFailure) {}
        },
            (bool b) {},
      );

      // Refresh
      this.getUserProfil(userProfil!.uuid);
      notifyListeners();
    }

  }

  void getUserProfil(String uuid) async {
    userProfil = null;
    failure = null;
    posts = [];
    notifyListeners();

    UserProfilRepository repository =
        await UserProfilRepository.getUserProfilRepository();

    // Get User infos
    if (uuid == UserInfo.user.uuid) {
      this.isMyUserProfil = true;
    } else {
      this.isMyUserProfil = false;
    }
    final failureOrUserProfil =
        await GetUserProfil(userProfilRepository: repository).call(uuid: uuid);
    failureOrUserProfil.fold(
      (Failure failure) {
        userProfil = null;
        this.failure = failure;
        notifyListeners();
      },
      (UserProfilEntity userProfilEntity) {
        print(userProfilEntity.uuid);
        userProfil = userProfilEntity;
        failure = null;

        if (!this.isMyUserProfil) {
          this.isFollower = checkIsFollower();
        }

        this.getUserPosts();

        notifyListeners();
      },
    );
  }

  void getUserPosts() async {
    PostRepository repository = await PostRepository.getPostRepository();
    final failureOrPosts =
        await GetAllPostInRangeWithUserUUID(postRepository: repository)
            .call(range: 10, userUuid: userProfil!.uuid);
    failureOrPosts.fold(
      (Failure failure) {},
      (List<PostEntity> userPosts) {
        this.posts = userPosts;
        notifyListeners();
      },
    );
  }

  void changeProfilPicture() async {
    if (this.isMyUserProfil) {
      UserProfilRepository repository =
          await UserProfilRepository.getUserProfilRepository();
      final XFile? image =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        final failureOrPP =
            await ChangeProfilPicture(userProfilRepository: repository)
                .call(uuid: userProfil!.uuid, image: File(image.path));
        failureOrPP.fold(
          (Failure failure) {},
          (bool b) {
          },
        );

        // Refresh
        this.getUserProfil(userProfil!.uuid);
        notifyListeners();
      }
    }
  }

  void blockUser() async {
    if (!this.isMyUserProfil) {
      UserProfilRepository repository =
          await UserProfilRepository.getUserProfilRepository();
      final failureOrBlock = await BlockUserProfil(userProfilRepository: repository).call(uuid: userProfil!.uuid);
      failureOrBlock.fold(
            (Failure failure) {},
            (bool b) {
        },
      );
      // Refresh
      this.getUserProfil(userProfil!.uuid);
      notifyListeners();
    }
  }
}
