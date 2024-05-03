import 'dart:io';

import 'package:descolar_front/features/profil/business/entities/user_profil_entity.dart';

class UserProfilModel extends UserProfilEntity {
  const UserProfilModel({
    required String uuid,
    required String firstname,
    required String lastname,
    required String username,
    required List<UserProfilEntity> followers,
    required List<UserProfilEntity> following,
    File? pp,
  }) : super(
          uuid: uuid,
          firstname: firstname,
          lastname: lastname,
          username: username,
          followers: followers,
          following: following,
          pp: pp,
        );

  factory UserProfilModel.fromJson({required Map<String, dynamic> json}) {
    // TODO : put json data in UserProfilModel
    List<UserProfilEntity> followers = [];
    List<UserProfilEntity> following = [];

    List<dynamic> jsonFollowers = json['followers'] ?? [];
    List<dynamic> jsonFollowing = json['following'] ?? [];

    for (var f in jsonFollowers) {
      followers.add(
        UserProfilEntity(
          uuid: f['uuid'],
          firstname: f['firstname'] ?? '-',
          lastname: f['lastname'] ?? '-',
          username: f['username'] ?? '-',
          followers: [],
          following: [],
          pp : f['pfpPath'] != null ? File(f['pfpPath']) : null,
        ),
      );
    }

    for (var f in jsonFollowing) {
      following.add(
        UserProfilEntity(
          uuid: f['uuid'] ?? '-',
          firstname: f['firstname'] ?? '-',
          lastname: f['lastname'] ?? '-',
          username: f['username'] ?? '-',
          followers: [],
          following: [],
          pp : f['pfpPath'] != null ? File(f['pfpPath']) : null,
        ),
      );
    }

    return UserProfilModel(
      uuid: json['uuid'] ?? '-',
      firstname: json['firstname'] ?? '-',
      lastname: json['lastname'] ?? '-',
      username: json['username'] ?? '-',
      followers: followers,
      following: following,
      pp : json['pfpPath'] != null ? File(json['pfpPath']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'firstname': firstname,
      'lastname': lastname,
      'username': username,
      'followers': followers,
      'following': following,
      'pfpPath': pp?.path,
    };
  }
}
