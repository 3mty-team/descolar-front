import 'package:descolar_front/features/profil/business/entities/user_profil_entity.dart';

class UserProfilModel extends UserProfilEntity {
  const UserProfilModel({
    required String uuid,
    required String firstname,
    required String lastname,
    required String username,
    required List<UserProfilEntity> followers,
    required List<UserProfilEntity> following,
    required String? pfpPath,
    required String? bannerPath,
  }) : super(
          uuid: uuid,
          firstname: firstname,
          lastname: lastname,
          username: username,
          followers: followers,
          following: following,
          pfpPath: pfpPath,
          bannerPath: bannerPath,
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
          followers: [],
          following: [],
          pfpPath: f['pfpPath'],
          bannerPath: f['bannerPath'],
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
          pfpPath: f['pfpPath'],
          bannerPath: f['bannerPath'],
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
      pfpPath: json['pfpPath'],
      bannerPath: json['bannerPath'],
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
      'followers': jsonFollowers,
      'following': jsonFollowings,
      'pfpPath': pfpPath,
      'bannerPath': bannerPath,
    };
  }
}
