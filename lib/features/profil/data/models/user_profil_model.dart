import 'package:descolar_front/features/profil/business/entities/user_profil_entity.dart';

class UserProfilModel extends UserProfilEntity {
  const UserProfilModel({
    required String uuid,
    required String firstname,
    required String lastname,
    required String username,
    required String diploma,
    required String formation,
    required List<UserProfilEntity> followers,
    required List<UserProfilEntity> following,
    required String? pfpPath,
    required String? bannerPath,
    required String? biography,
  }) : super(
          uuid: uuid,
          firstname: firstname,
          lastname: lastname,
          username: username,
          diploma: diploma,
          formation: formation,
          followers: followers,
          following: following,
          pfpPath: pfpPath,
          bannerPath: bannerPath,
          biography: biography,
        );

  factory UserProfilModel.fromJson({required Map<String, dynamic> json}) {
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
          diploma: f['formation']['diploma']['name'],
          formation: f['formation']['name'],
          followers: [],
          following: [],
          pfpPath: f['pfpPath'],
          bannerPath: f['bannerPath'],
          biography: f['biography'],
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
          diploma: f['formation']['diploma']['name'],
          formation: f['formation']['name'],
          followers: [],
          following: [],
          pfpPath: f['pfpPath'],
          bannerPath: f['bannerPath'],
          biography: f['biography'],
        ),
      );
    }

    return UserProfilModel(
      uuid: json['uuid'] ?? '-',
      firstname: json['firstname'] ?? '-',
      lastname: json['lastname'] ?? '-',
      username: json['username'] ?? '-',
      diploma: json['formation']['diploma']['name'],
      formation: json['formation']['name'],
      followers: followers,
      following: following,
      pfpPath: json['pfpPath'],
      bannerPath: json['bannerPath'],
      biography: json['biography'],
    );
  }

  Map<String, dynamic> toJson() {
    List<dynamic> jsonFollowers = [];
    List<dynamic> jsonFollowings = [];

    for (var f in followers) {
      jsonFollowers.add({
        'uuid': f.uuid,
        'firstname': f.firstname,
        'lastname': f.lastname,
        'username': f.username,
        'diploma': f.diploma,
        'formation': f.formation,
        'biography': f.biography,
        'followers': [],
        'following': [],
        'pfpPath': f.pfpPath,
        'bannerPath': f.bannerPath,
      });
    }

    for (var f in following) {
      jsonFollowings.add({
        'uuid': f.uuid,
        'firstname': f.firstname,
        'lastname': f.lastname,
        'username': f.username,
        'diploma': f.diploma,
        'formation': f.formation,
        'biography': f.biography,
        'followers': [],
        'following': [],
        'pfpPath': f.pfpPath,
        'bannerPath': f.bannerPath,
      });
    }

    return {
      'uuid': uuid,
      'firstname': firstname,
      'lastname': lastname,
      'username': username,
      'diploma': diploma,
      'formation': formation,
      'biography': biography,
      'followers': jsonFollowers,
      'following': jsonFollowings,
      'pfpPath': pfpPath,
      'bannerPath': bannerPath,
    };
  }
}
