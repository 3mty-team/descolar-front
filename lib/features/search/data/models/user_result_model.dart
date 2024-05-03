import 'dart:io';

import 'package:descolar_front/features/search/business/entities/user_result_entity.dart';

class UserResultModel extends UserResultEntity {
  const UserResultModel({
    required String uuid,
    required String username,
    required int followingNb,
    required int followersNb,
    File? userPfp,
  }) : super(
          uuid: uuid,
          username: username,
          followingNb: followingNb,
          followersNb: followersNb,
          userPfp: userPfp,
        );

  factory UserResultModel.fromJson({required Map<String, dynamic> json}) {
    return UserResultModel(
      uuid: json['uuid'],
      username: json['username'],
      followersNb: json['followers'],
      followingNb: json['followings'],
      userPfp: json['pfpPath'] == null ? null : File(json['pfpPath']),
    );
  }
}
